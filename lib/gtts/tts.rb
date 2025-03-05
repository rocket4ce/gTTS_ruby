# frozen_string_literal: true

require "http"
require "json"
require "base64"
require "logger"
require "cgi"
require "uri"

module Gtts
  class Speed
    SLOW = true
    NORMAL = nil
  end

  class GttsError < StandardError
    attr_reader :tts, :response

    def initialize(msg = nil, tts: nil, response: nil)
      @tts = tts
      @response = response
      @msg = msg || infer_msg
      super(@msg)
    end

    private

    def infer_msg
      cause = "Unknown"

      if @response.nil?
        premise = "Failed to connect"
        cause = "Host '#{_translate_url}' is not reachable" if @tts&.tld != "com"
      else
        status = @response.status
        reason = @response.reason

        premise = "#{status} (#{reason}) from TTS API"

        cause = case status
               when 403 then "Bad token or upstream API changes"
               when 404 then @tts&.tld != "com" ? "Unsupported tld '#{@tts.tld}'" : "Not found"
               when 200 then "No audio stream in response. Unsupported language '#{@tts.lang}'" unless @tts&.lang_check
               when 500..599 then "Upstream API error. Try again later."
               end
      end

      "#{premise}. Probable cause: #{cause}"
    end
  end

  class GTTS
    GOOGLE_TTS_MAX_CHARS = 100
    GOOGLE_TTS_HEADERS = {
      "Referer" => "http://translate.google.com/",
      "User-Agent" => "Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/47.0.2526.106 Safari/537.36",
      "Content-Type" => "application/x-www-form-urlencoded;charset=utf-8"
    }.freeze
    GOOGLE_TTS_RPC = "jQ1olc"

    attr_reader :text, :tld, :lang, :lang_check, :speed

    def initialize(text, tld: "com", lang: "en", slow: false, lang_check: true)
      raise ArgumentError, "No text to speak" if text.nil? || text.empty?

      @text = text
      @tld = tld
      @lang_check = lang_check
      @lang = lang
      @speed = slow ? Speed::SLOW : Speed::NORMAL

      validate_language if @lang_check
    end

    def stream
      prepared_requests.each_with_index do |request, idx|
        client = HTTP.headers(GOOGLE_TTS_HEADERS)

        begin
          response = client.post(request[:url], form: {"f.req" => request[:body]})

          unless response.status.success?
            raise GttsError.new(tts: self, response: response)
          end

          response.body.to_s.each_line do |line|
            decoded_line = line.force_encoding("UTF-8")
            if decoded_line.include?("jQ1olc")
              if (audio_match = decoded_line.match(/jQ1olc","\[\\"(.*?)\\"\]/))
                as_bytes = audio_match[1].encode("ASCII")
                yield Base64.decode64(as_bytes)
              else
                raise GttsError.new(tts: self, response: response)
              end
            end
          end
        rescue HTTP::Error => e
          raise GttsError.new(tts: self, response: response)
        end
      end
    end

    def save(filename)
      File.open(filename, "wb") do |file|
        stream { |chunk| file.write(chunk) }
      end
    end

    private

    def validate_language
      return unless @lang_check

      unless Lang.supported?(@lang)
        raise ArgumentError, "Language not supported: #{@lang}"
      end
    end

    def prepared_requests
      text_parts = tokenize(@text)
      raise GttsError.new("No text to send to TTS API") if text_parts.empty?

      text_parts.map do |part|
        {
          url: translate_url,
          body: package_rpc(part)
        }
      end
    end

    def tokenize(text)
      # Simple tokenization for now - split by maximum character length
      # TODO: Implement more sophisticated tokenization like the Python version
      text.scan(/.{1,#{GOOGLE_TTS_MAX_CHARS}}/m)
    end

    def translate_url
      "https://translate.google.#{@tld}/_/TranslateWebserverUi/data/batchexecute"
    end

    def package_rpc(text)
      params = [text, @lang, @speed, "null"]
      escaped_params = params.to_json

      rpc = [[[GOOGLE_TTS_RPC, escaped_params, nil, "generic"]]]
      rpc.to_json
    end
  end
end

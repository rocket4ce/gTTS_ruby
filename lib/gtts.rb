# frozen_string_literal: true

require_relative "gtts/version"
require_relative "gtts/lang"
require_relative "gtts/tts"

module Gtts
  class Error < StandardError; end

  # Shortcut for creating a new GTTS instance
  def self.create(text, **options)
    GTTS.new(text, **options)
  end

  # Get list of supported languages
  def self.languages
    Lang.tts_langs
  end

  # Check if a language is supported
  def self.language_supported?(lang_code)
    Lang.supported?(lang_code)
  end
end

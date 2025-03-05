# frozen_string_literal: true

module Gtts
  module Lang
    LANGUAGES = {
      "af" => "Afrikaans",
      "ar" => "Arabic",
      "bg" => "Bulgarian",
      "bn" => "Bengali",
      "bs" => "Bosnian",
      "ca" => "Catalan",
      "cs" => "Czech",
      "cy" => "Welsh",
      "da" => "Danish",
      "de" => "German",
      "el" => "Greek",
      "en" => "English",
      "eo" => "Esperanto",
      "es" => "Spanish",
      "et" => "Estonian",
      "fi" => "Finnish",
      "fr" => "French",
      "gu" => "Gujarati",
      "hi" => "Hindi",
      "hr" => "Croatian",
      "hu" => "Hungarian",
      "hy" => "Armenian",
      "id" => "Indonesian",
      "is" => "Icelandic",
      "it" => "Italian",
      "ja" => "Japanese",
      "jw" => "Javanese",
      "km" => "Khmer",
      "kn" => "Kannada",
      "ko" => "Korean",
      "la" => "Latin",
      "lv" => "Latvian",
      "mk" => "Macedonian",
      "ml" => "Malayalam",
      "mr" => "Marathi",
      "my" => "Myanmar (Burmese)",
      "ne" => "Nepali",
      "nl" => "Dutch",
      "no" => "Norwegian",
      "pl" => "Polish",
      "pt" => "Portuguese",
      "ro" => "Romanian",
      "ru" => "Russian",
      "si" => "Sinhala",
      "sk" => "Slovak",
      "sq" => "Albanian",
      "sr" => "Serbian",
      "su" => "Sundanese",
      "sv" => "Swedish",
      "sw" => "Swahili",
      "ta" => "Tamil",
      "te" => "Telugu",
      "th" => "Thai",
      "tl" => "Filipino",
      "tr" => "Turkish",
      "uk" => "Ukrainian",
      "ur" => "Urdu",
      "vi" => "Vietnamese",
      "zh-CN" => "Chinese"
    }.freeze

    def self.tts_langs
      LANGUAGES
    end

    def self.supported?(lang_code)
      LANGUAGES.key?(lang_code)
    end
  end
end

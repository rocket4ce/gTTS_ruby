# GTTS Ruby

A Ruby library and CLI tool to interface with Google Translate's Text-to-Speech API. This is a Ruby port of the Python [gTTS](https://github.com/pndurette/gTTS) library.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'gtts'
```

And then execute:

```bash
$ bundle install
```

Or install it yourself as:

```bash
$ gem install gtts
```

## Usage

### As a Library

```ruby
require 'gtts'

# Simple example
tts = Gtts::GTTS.new("Hello World")
tts.save("hello.mp3")

# More options
tts = Gtts::GTTS.new(
  "Hola Mundo",
  lang: "es",     # Language
  tld: "com.mx",  # Top-level domain
  slow: true      # Slower speed
)
tts.save("hola.mp3")

# Stream the audio data
tts.stream do |audio_chunk|
  # Process audio data chunks
  # For example, write to a file
  File.open("output.mp3", "ab") { |f| f.write(audio_chunk) }
end

# Check supported languages
Gtts.languages.each do |code, name|
  puts "#{code}: #{name}"
end

# Check if a language is supported
puts Gtts.language_supported?("es") # true
puts Gtts.language_supported?("xx") # false
```

### Command Line Tool

The gem comes with a command-line tool called `gtts-cli`:

```bash
# Basic usage
gtts-cli "Hello World" -o hello.mp3

# Specify language
gtts-cli "Hola Mundo" -l es -o hola.mp3

# Read from file
gtts-cli -f input.txt -o output.mp3

# List available languages
gtts-cli --list-langs

# Show all options
gtts-cli --help
```

### CLI Options

- `-f, --file FILE` : Read text from file
- `-o, --output FILE` : Output file (default: output.mp3)
- `-l, --lang LANG` : Language (default: en)
- `-t, --tld TLD` : Top-level domain for Google Translate
- `-s, --slow` : Speak more slowly
- `--list-langs` : List available languages
- `--debug` : Debug mode
- `-h, --help` : Show help message

## Supported Languages

The library supports multiple languages. Use `gtts-cli --list-langs` to see all available languages or check `Gtts.languages` in your code.

## Contributing

Bug reports and pull requests are welcome on GitHub.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

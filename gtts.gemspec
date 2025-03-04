# frozen_string_literal: true

require_relative "lib/gtts/version"

Gem::Specification.new do |spec|
  spec.name = "gtts"
  spec.version = Gtts::VERSION
  spec.authors = ["rocket4ce"]
  spec.email = ["rocket4ce@gmail.com"]

  spec.summary = "Ruby implementation of gTTS (Google Text-to-Speech)"
  spec.description = "gTTS (Google Text-to-Speech) is a Ruby library and CLI tool to interface with Google Translate text-to-speech API"
  spec.homepage = "https://github.com/rocket4ce/gTTS_ruby"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.1.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/rocket4ce/gTTS_ruby"
  spec.metadata["changelog_uri"] = "https://github.com/rocket4ce/gTTS_ruby/blob/main/CHANGELOG.md"
  spec.metadata["rubygems_mfa_required"] = "true"

  # Include all files in the gem
  spec.files = Dir.glob(%w[
    lib/**/*.rb
    exe/**/*
    *.gemspec
    README.md
    LICENSE.txt
  ])

  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Dependencies
  spec.add_dependency "http", "~> 5.1"  # For making HTTP requests
  spec.add_dependency "json", "~> 2.6"  # For JSON handling

  # Development dependencies
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rubocop", "~> 1.21"
end

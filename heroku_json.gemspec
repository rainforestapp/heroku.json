# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'herokujson/version'

Gem::Specification.new do |spec|
  spec.name          = "heroku.json"
  spec.version       = HerokuJson::VERSION
  spec.authors       = ["Russell Smith", "Simon Mathieu", "Fred Stevens-Smith"]
  spec.email         = ["russ@rainforestqa.com", "simon.math@gmail.com", "fred@rainforestqa.com"]
  spec.description   = %q{Heroku.json is configuration management for Heroku, making it super simple to setup (import) and copy (export) Heroku apps.}
  spec.summary       = %q{Configuration management for Heroku}
  spec.homepage      = "https://github.com/rainforestapp/heroku.json"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"

  spec.add_dependency 'heroku'
end

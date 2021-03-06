# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'spira/timestamps/version'

Gem::Specification.new do |spec|
  spec.name          = "spira-timestamps"
  spec.version       = Spira::Timestamps::VERSION
  spec.authors       = ["Nicholas Hurden"]
  spec.email         = ["git@nhurden.com"]
  spec.summary       = %q{A Spira plugin for automatic timestamps}
  spec.description   = spec.summary
  #spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.required_ruby_version = '>= 1.9.3'

  spec.add_runtime_dependency "spira", "~> 0.7"
  spec.add_runtime_dependency "activesupport", "~> 4.0"

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.1"
  spec.add_development_dependency "yard", "~> 0.6"
end

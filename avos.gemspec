# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'avos/version'

Gem::Specification.new do |spec|
  spec.name          = "avos"
  spec.version       = AVOS::VERSION
  spec.authors       = ["herbert"]
  spec.email         = ["loveltyoic@gmail.com"]
  spec.description   = %q{AVOS ruby sdk}
  spec.summary       = %q{AVOS ruby sdk}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_dependency "faraday", ">= 0.9.1"
  spec.add_dependency "activesupport"
end

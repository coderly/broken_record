# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'broken_record/version'

Gem::Specification.new do |spec|
  spec.name          = "broken_record"
  spec.version       = BrokenRecord::VERSION
  spec.authors       = ["Venkat Dinavahi"]
  spec.email         = ["venkat@coderly.com"]
  spec.description   = %q{Find all references in your ActiveRecord models that are broken}
  spec.summary       = %q{Find all references in your ActiveRecord models that are broken}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "activerecord", ">= 4.0"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end

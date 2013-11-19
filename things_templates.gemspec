# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'things_templates/version'

Gem::Specification.new do |spec|
  spec.name          = "things_templates"
  spec.version       = ThingsTemplates::VERSION
  spec.authors       = ["Chris Svenningsen"]
  spec.email         = ["crsven@gmail.com"]
  spec.description   = "Templating for Things.app"
  spec.summary       = "Easy(?) templating for Things.app. Create and build templates of projects, items and tags."
  spec.homepage      = "https://github.com/crsven/things_templates"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "cane"
end

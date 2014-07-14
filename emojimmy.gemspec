# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'emojimmy/version'

Gem::Specification.new do |spec|
  spec.name          = 'emojimmy'
  spec.version       = Emojimmy::VERSION
  spec.authors       = ['Rémi Prévost']
  spec.email         = ['rprevost@mirego.com']
  spec.description   = 'Emojimmy makes it possible to store emoji characters in ActiveRecord datastores that don’t support 4-Byte UTF-8 Unicode encoding.'
  spec.summary       = spec.description
  spec.homepage      = 'http://open.mirego.com/emojimmy'
  spec.license       = 'BSD 3-Clause'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'activerecord', '>= 3.0.0'
  spec.add_dependency 'rumoji', '>= 0.3.1'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rspec-its'
  spec.add_development_dependency 'coveralls'
  spec.add_development_dependency 'sqlite3'
end

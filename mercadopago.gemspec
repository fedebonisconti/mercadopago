# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mercadopago/version'

Gem::Specification.new do |spec|
  spec.name          = "mercadopago-rb"
  spec.version       = Mercadopago::VERSION
  spec.authors       = ["Federico Bonisconti"]
  spec.email         = ["fedebonisconti26@gmail.com"]
  spec.licenses      = ["MIT"]
  spec.summary       = "Object-oriented wrapper for mercadopago's API."
  spec.description   = "Object-oriented wrapper for mercadopago's API."
  spec.homepage      = "https://github.com/fedebonisconti/mercadopago"

  spec.require_paths = ["lib"]
  spec.required_ruby_version = '>= 2.1.0'
  spec.files = `git ls-files`.split("\n")

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end

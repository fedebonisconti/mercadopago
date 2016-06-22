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
  spec.summary       = %q{Object-oriented wrapper for mercadopago's API.}
  spec.description   = %q{Object-oriented wrapper for mercadopago's API.}
  spec.homepage      = "https://github.com/fedebonisconti/mercadopago"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end

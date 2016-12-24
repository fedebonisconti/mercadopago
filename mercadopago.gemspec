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
  spec.summary       = %Q{Object-oriented wrapper for mercadopago's API.}
  spec.description   = %Q{Object-oriented wrapper for mercadopago's API.}
  spec.homepage      = "https://github.com/fedebonisconti/mercadopago"


  spec.files         = `git ls-files`.split("\n")
  spec.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  spec.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.required_ruby_version = '>= 2.1.0'

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "webmock", "~> 2.3.1"
end

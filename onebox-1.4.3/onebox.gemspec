# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'onebox/version'

Gem::Specification.new do |spec|
  spec.name          = "onebox"
  spec.version       = Onebox::VERSION
  spec.authors       = ["Joanna Zeta", "Vyki Englert", "Robin Ward"]
  spec.email         = ["holla@jzeta.com", "vyki.englert@gmail.com", "robin.ward@gmail.com"]
  spec.description   = %q{A gem for turning URLs into previews.}
  spec.summary       = spec.description
  spec.homepage      = "https://github.com/discourse/onebox"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "multi_json", "~> 1.7"
  spec.add_runtime_dependency "mustache", "~> 0.99"
  spec.add_runtime_dependency "nokogiri", "~> 1.6.1"
  spec.add_runtime_dependency "moneta", "~> 0.7"
  spec.add_runtime_dependency "monetize", "~> 0.3.0"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 2.14"
  spec.add_development_dependency "yard", "~> 0.8"
  spec.add_development_dependency "fakeweb", "~> 1.3"
  spec.add_development_dependency "pry", "~> 0.9"
  spec.add_development_dependency "mocha", "~> 0.14"
  spec.add_development_dependency "rubocop", "~> 0.11"
  spec.add_development_dependency "twitter", "~> 4.8"
  spec.add_development_dependency "guard-rspec", "~> 4.2.8"
  spec.add_development_dependency "pry", "~> 0.10.0"
  # listen current is a bit broken
  # http://stackoverflow.com/questions/21319753/readline-seems-to-be-broken
  spec.add_development_dependency "listen", "= 2.6.0"
end

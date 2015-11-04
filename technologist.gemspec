# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'technologist/version'

Gem::Specification.new do |spec|
  spec.name          = "technologist"
  spec.version       = Technologist::VERSION
  spec.authors       = ["Alexis Reigel"]
  spec.email         = ["mail@koffeinfrei.org"]

  spec.summary       = %q{Detects the technologies used in a repository.}
  spec.description   = %q{Detects technologies in a repository by applying a set of rules and returning primary and secondary frameworks.}
  spec.homepage      = "https://github.com/koffeinfrei/technologist"
  spec.license       = "AGPL-3.0"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "rugged", "~> 0.23.3"
  spec.add_runtime_dependency "nokogiri", "~> 1.6"
  spec.add_runtime_dependency "slop", "~> 3.4" # we can't use version 4 due to pry's dependecy

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.3"
  spec.add_development_dependency "pry", "~> 0.10"
end

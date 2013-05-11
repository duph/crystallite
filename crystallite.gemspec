# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'crystallite/version'

Gem::Specification.new do |gem|
  gem.name          = "crystallite"
  gem.version       = Crystallite::VERSION
  gem.authors       = ["Fredrik Persen Fostvedt"]
  gem.email         = ["fpfostvedt@gmail.com"]
  gem.description   = "Creates crystall branches from polygon crystallites"
  gem.summary       = "Crystallite brancher"
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end

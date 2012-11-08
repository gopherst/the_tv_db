# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'the_tv_db/version'

Gem::Specification.new do |gem|
  gem.name          = "the_tv_db"
  gem.version       = TheTvDB::VERSION
  gem.authors       = ["Javier Saldana"]
  gem.email         = ["javier@tractical.com"]
  gem.description   = %q{Ruby API Client for TheTvDB.com}
  gem.summary       = %q{TheTvDB.com API Client}
  gem.homepage      = "https://github.com/jassa/the_tv_db"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  
  gem.add_dependency "faraday",   "~> 0.8.4"
  gem.add_dependency "ox",        "~> 1.6.6"
  gem.add_dependency "multi_xml", "~> 0.5.1"
  gem.add_dependency "rubyzip",   "~> 0.9.9"
  
  gem.add_development_dependency "rspec", "~> 2.11.0"
  gem.add_development_dependency "webmock", "~> 1.9.0"
end

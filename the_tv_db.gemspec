# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'the_tv_db/version'

Gem::Specification.new do |gem|
  gem.name          = "the_tv_db"
  gem.version       = TheTvDb::VERSION
  gem.authors       = ["Javier Saldana"]
  gem.email         = ["javier@tractical.com"]
  gem.description   = %q{TheTvDB.com API Client}
  gem.summary       = %q{Ruby API Client for TheTvDB.com}
  gem.homepage      = "https://github.com/jassa/the_tv_db"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end

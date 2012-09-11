# -*- encoding: utf-8 -*-
require File.expand_path('../lib/ripple-compression/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Casey Rosenthal"]
  gem.email         = ["clr@port49.com"]
  gem.description   = %q{Compress ripple documents before storing them in Riak.}
  gem.summary       = %q{Compress ripple documents before storing them in Riak.}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "ripple-compression"
  gem.require_paths = ["lib"]
  gem.version       = Ripple::Compression::VERSION

  gem.add_dependency 'riak-client'
  gem.add_dependency 'ripple'

  # Test Dependencies
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'contest'
end

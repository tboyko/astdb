# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'astdb/version'

Gem::Specification.new do |gem|
  gem.name          = "astdb"
  gem.version       = Astdb::VERSION
  gem.authors       = ["Taylor Boyko"]
  gem.email         = ["taylor@wrprojects.com"]
  gem.description   = %q{Interact with an Asterisk Database (AstDB) instance via ssh.}
  gem.summary       = %q{}
  gem.homepage      = "https://github.com/tboyko/astdb"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  
  gem.add_dependency 'net-ssh'
end

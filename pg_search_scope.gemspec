# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "pg_search_scope/version"

Gem::Specification.new do |s|
  s.name        = "pg_search_scope"
  s.version     = PgSearchScope::VERSION
  s.authors     = ["Ivan Efremov, Ilia Ablamonov, Cloud Castle Inc."]
  s.email       = ["ilia@flamefork.ru", "st8998@gmail.com"]
  s.homepage    = "https://github.com/cloudcastle/pg_search_scope"
  s.summary     = %q{PostgreSQL full text search using Rails 3 scopes}
  s.description = %q{}

  s.rubyforge_project = "pg_search_scope"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end

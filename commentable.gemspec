# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "commentable/version"

Gem::Specification.new do |s|
  s.name        = "commentable"
  s.version     = Commentable::Version::STRING
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Nando Vieira"]
  s.email       = ["fnando.vieira@gmail.com"]
  s.homepage    = "http://rubygems.org/gems/commentable"
  s.summary     = "Add comment support for ActiveRecord models."
  s.description = s.summary

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "activerecord"
  s.add_development_dependency "rake", "~> 0.8.7"
  s.add_development_dependency "rspec", "~> 2.6"
  s.add_development_dependency "sqlite3", "~> 1.3"
  s.add_development_dependency "test_notifier", "~> 0.3.6"
  s.add_development_dependency "ruby-debug19"
  s.add_development_dependency "redcarpet", "~> 1.17"
end

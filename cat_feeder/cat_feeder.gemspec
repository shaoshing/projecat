# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name    = "cat_feeder"
  s.version = "0.0.1"
  s.author  = "Shaoshing Lee"
  s.email   = "shaoshing@me.com"
  s.date    = "2013-04-30"
  s.summary = ""

  s.has_rdoc = false
  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.files = Dir.glob("lib/**/*")
  s.require_paths = ["lib"]
  s.required_ruby_version = '>= 1.9'

  s.add_dependency 'pi_piper'
  s.add_dependency 'data_mapper'
  s.add_dependency 'dm-sqlite-adapter'
  s.add_dependency 'sqlite3'
end

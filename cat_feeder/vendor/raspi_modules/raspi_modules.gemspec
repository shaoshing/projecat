# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name    = "raspi_modules"
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

  s.add_development_dependency 'pi_piper'
end

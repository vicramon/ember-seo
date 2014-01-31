# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

Gem::Specification.new do |s|
  s.name = "ember-seo"
  s.version = "0.1"
  s.license = "MIT"

  s.authors = "Vic Ramon"
  s.email = "vic@vicramon.com"
  s.description = "Ember Seo helps you make you Ember app crawlable by Google."

  s.homepage = ""
  s.require_paths = ["lib"]
  s.summary = "Ember Seo helps you make you Ember app crawlable by Google."

  s.required_ruby_version = '>= 1.9.3'

  s.add_development_dependency("rake")
  s.add_development_dependency("rspec")
  s.add_development_dependency("pry")
  s.add_development_dependency("capybara")
  s.add_development_dependency("poltergeist")

  s.files = Dir.glob("lib/**/*") + %w(README.md)
  s.require_path = "lib"

end

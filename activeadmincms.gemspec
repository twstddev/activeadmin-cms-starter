$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "activeadmincms/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "activeadmincms"
  s.version     = Activeadmincms::VERSION
  s.authors     = ["Rustam Chakin"]
  s.email       = ["twstd.dev@gmail.com"]
  s.homepage    = "https://github.com/twstddev/activeadmin-cms-starter"
  s.summary     = "A simple page and meta fields functionality."
  s.description = "This gem adds basic page scaffold and support for nested meta fields based on model serialize field."

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.0.4"
  s.add_dependency "sass-rails", "4.0.2"
  s.add_dependency "jbuilder"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "capybara"
  s.add_development_dependency "database_cleaner"
  s.add_development_dependency "generator_spec"
  s.add_development_dependency "spork-rails"
end

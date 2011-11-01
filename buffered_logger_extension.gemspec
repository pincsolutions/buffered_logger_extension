$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "buffered_logger_extension/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "buffered_logger_extension"
  s.version     = BufferedLoggerExtension::VERSION
  s.authors     = ["Christopher Maujean"]
  s.email       = ["cmaujean@pincsolutions.com"]
  s.homepage    = "http://www.pincsolutions.com/"
  s.summary     = "TODO: Summary of BufferedLoggerExtension."
  s.description = "TODO: Description of BufferedLoggerExtension."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", "~> 3.1.1"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "pry"
end

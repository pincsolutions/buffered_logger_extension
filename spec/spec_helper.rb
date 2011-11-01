require 'rspec'
require File.expand_path("../dummy/config/environment.rb",  __FILE__)

ENV["RAILS_ENV"] = "test"

Rails.backtrace_cleaner.remove_silencers!

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

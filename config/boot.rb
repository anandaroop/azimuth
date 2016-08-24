ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../Gemfile', __dir__)

require 'bundler/setup' # Set up gems listed in the Gemfile.

unless ENV['RAILS_ENV'] == 'production'
  require 'dotenv'
  Dotenv.load
end

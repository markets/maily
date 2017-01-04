ENV['RAILS_ENV'] = 'test'
require File.expand_path("../dummy/config/environment.rb", __FILE__)
require 'rspec/rails'
require 'maily'

RSpec.configure do |config|
  config.mock_with :rspec
  config.order = 'random'
end

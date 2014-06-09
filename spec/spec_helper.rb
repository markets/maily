$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

ENV['RAILS_ENV'] = 'test'
require File.expand_path("../dummy/config/environment.rb", __FILE__)

require 'rspec/rails'
require 'maily'

RSpec.configure do |config|
  config.mock_with :rspec
  config.order = 'random'
end

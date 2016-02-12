$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'pry'
require 'rulers'
require 'rspec/given'
require 'rack/test'
require 'test/unit'
include Rack::Test::Methods

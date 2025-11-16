# frozen_string_literal: true

ENV["RACK_ENV"] = "test"

require "simplecov"

SimpleCov.start do
  enable_coverage :branch
  add_filter "/spec/"
  minimum_coverage line: 100, branch: 100
end

require "json"
require "rack/test"
require "rspec"

$LOAD_PATH.unshift File.expand_path("../app", __dir__)
require "app"

module AppHelper
  def app
    ClaviusTales::App.new
  end
end

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.include Rack::Test::Methods
  config.include AppHelper
end

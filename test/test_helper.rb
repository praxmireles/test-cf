# frozen_string_literal: true

require 'simplecov'
SimpleCov.start do
  add_filter(%r{/^\/spec\//}) # For RSpec
  add_filter(%r{/^\/test\//}) # For Minitest
  add_filter('/app/dashboards')
  add_filter('/app/controllers/admin')
end

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)
require 'rails/test_help'
require 'minitest/unit'
require 'minitest/rails'
require 'minitest/rails/capybara'
require 'shoulda/matchers'

SimpleCov.start 'rails'

class ActiveSupport::TestCase
  include FactoryBot::Syntax::Methods
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical
  # order.
  fixtures :all
end
require 'mocha/minitest'

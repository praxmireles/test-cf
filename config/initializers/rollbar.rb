# frozen_string_literal: true

require 'rollbar'

Rollbar.configure do |config|
  config.access_token = ENV['ROLLBAR_ACCESS_TOKEN']
  config.environment = Rails.env
  config.enabled = if Rails.env.development?
                     false
                   else
                     true
                   end
end

# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

if Rails.env.development?
  require 'dotenv-rails'
  Dotenv::Railtie.load
end

HOSTNAME = ENV['HOSTNAME']

module Mindwithpurpose
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # config.time_zone = 'Eastern Time (US & Canada)'
    config.autoload_paths += %W[#{Rails.root}/app/models/appointment_packs]
    config.autoload_paths += %W[#{Rails.root}/app/models/appointments]
    config.autoload_paths += %W[#{Rails.root}/app/models/notifications]
    config.autoload_paths += %W[#{Rails.root}/app/models/requests]
    config.autoload_paths += %W[#{Rails.root}/app/models/services]
    config.autoload_paths += %W[#{Rails.root}/app/models/users]
    config.autoload_paths += %W[#{Rails.root}/app/models/admin_users]
    config.autoload_paths += %W[#{Rails.root}/app/models/applicants]
    config.autoload_paths += %W[#{Rails.root}/app/models/ratings]
    config.autoload_paths += %W[#{Rails.root}/app/constants]
    config.autoload_paths += %W[#{Rails.root}/app/libs/utils]
  end
end

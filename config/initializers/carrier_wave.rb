# frozen_string_literal: true

require 'carrierwave/orm/activerecord'

if Rails.env.staging? || Rails.env.production?
  CarrierWave.configure do |config|
    config.fog_credentials = {
      provider:               'AWS',
      aws_access_key_id:      ENV['AWS_access_key_id'],
      aws_secret_access_key:  ENV['AWS_secret_key'],
      region:                 ENV['AWS_region']
    }
    # For testing, upload files to local `tmp` folder.
    if Rails.env.test? || Rails.env.cucumber?
      config.storage           = :file
      config.enable_processing = true
      config.root              = "#{Rails.root}/tmp"
    else
      config.storage = :fog
    end
    unless Rails.env.production?
      # To let CarrierWave work on Heroku
      config.cache_dir = "#{Rails.root}/tmp/uploads"
    end
    config.fog_directory = ENV['AWS_bucket']
  end
end

source 'https://rubygems.org'
ruby '2.5.1'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.2'
# Date and time validation plugin for ActiveModel and Rails. Supports multiple ORMs and allows custom date/time formats.
# https://github.com/adzap/validates_timeliness
gem 'validates_timeliness', '~> 5.0.0.alpha3'
# Use Puma as the app server
gem 'puma', '~> 3.12'
# Use SCSS for stylesheets
gem 'sass-rails'
# Embed the V8 Javascript Interpreter into Ruby
# https://github.com/cowboyd/therubyracer
gem 'therubyracer'
# Run JavaScript code from Ruby
# https://github.com/sstephenson/execjs
gem 'execjs'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# A Ruby static code analyzer and formatter, based on the community Ruby style guide
# https://github.com/rubocop-hq/rubocop
gem 'rubocop', '~> 0.58.2', require: false
gem 'rubocop-rspec'

# Pg is the Ruby interface to the PostgreSQL RDBMS
# https://github.com/ged/ruby-pg
gem 'pg'

# Simplifies template creation
# https://github.com/indirect/haml-rails
gem 'haml-rails', '1.0.0'

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

gem 'rb-readline', group: :development

# Roo provides an interface to spreadsheets of several sorts.
# https://github.com/roo-rb/roo
gem 'roo', '~> 2.7.1'

# OmniAuth is a flexible authentication system utilizing Rack middleware
# https://github.com/omniauth/omniauth
gem 'omniauth', '~> 1.8'

# Facebook OAuth2 Strategy for OmniAuth.
# https://github.com/mkdynamic/omniauth-facebook
gem 'omniauth-facebook', '~> 5.0.0'

# Linkedin https://github.com/omniauth/omniauth
# https://github.com/skorks/omniauth-linkedin
gem 'omniauth-linkedin-oauth2'

gem 'oauth2'

# OpenTok Server SDK for Ruby
# https://github.com/opentok/OpenTok-Ruby-SDK
gem 'opentok', '~> 3.0.3'

# Refactored to support more Ruby environments with code and documentation humbly used from the excellent bootstrap-sass project by the Bootstrap team
# https://github.com/FortAwesome/font-awesome-sass
gem 'font-awesome-sass', '~> 5.3.1'

# Roles : Minimal authorization through OO design and pure Ruby classes
# https://github.com/varvet/pundit
gem 'pundit', '~> 2.0.0'

# This gem packages the bootstrap-datetimepicker for the Rails 3.1+ asset pipeline.
# https://github.com/TrevorS/bootstrap3-datetimepicker-rails
gem 'bootstrap3-datetimepicker-rails', '~> 4.17.47'

# Moment JS
gem 'momentjs-rails', '~> 2.20.1'

# Ruby library for the Stripe API. https://stripe.com
# https://github.com/stripe/stripe-ruby
gem 'stripe', '~> 3.25.0'

# Ruby wrapper for UglifyJS JavaScript compressor.
# https://github.com/lautis/uglifier
gem 'uglifier', '~> 4.1.18'

# Forms made easy for Rails! It's tied to a simple DSL, with no opinion on markup.
# https://github.com/plataformatec/simple_form
gem 'simple_form', '~> 4.0.1'

# Solution for file uploads for Rails
# https://github.com/carrierwaveuploader/carrierwave
gem 'carrierwave', '~> 1.0'

# HTML-based templating language that converts\ HTML into responsive email-ready HTML.
# https://github.com/zurb/inky-rb
gem 'inky-rb', require: 'inky'

# Simple, efficient background processing for Ruby
# https://github.com/mperham/sidekiq
gem 'sidekiq'

# Lightweight job scheduler extension for Sidekiq
# https://github.com/moove-it/sidekiq-scheduler
gem 'sidekiq-scheduler'

# A Rails engine that helps you put together a super-flexible admin dashboard.
# https://github.com/thoughtbot/administrate
gem 'administrate'

# Track changes to your rails models
# https://github.com/paper-trail-gem/paper_trail
gem 'paper_trail'

# Dropzone awesome file upload JS library right into the Asset pipeline of your Rails apps.
# https://github.com/ncuesta/dropzonejs-rails
gem 'dropzonejs-rails'

# A Ruby Library for dealing with money and currency conversion.
# https://github.com/RubyMoney/money
gem 'money'
gem 'wicked_pdf'
gem 'wkhtmltopdf-binary'
gem 'paypal-sdk-rest'

group :staging, :production do
  # The Ruby cloud services library.
  # https://github.com/fog/fog
  gem 'fog'
end

group :test do
  # A Test::Unit runner that can run tests by line number.
  # https://github.com/qrush/m
  gem 'm', '~> 1.5.0'
  gem 'stripe-ruby-mock', '~> 2.5.0', require: 'stripe_mock'
end

group :development, :test do
  gem 'cypress-on-rails', '~> 1.0'
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  # https://github.com/deivid-rodriguez/byebug
  gem 'pry-byebug', platform: :mri

  # Currently, automatic factory definition loading is the only Rails-specific feature.
  # https://github.com/thoughtbot/factory_bot_rails
  gem 'factory_bot_rails', '~> 4.10'

  # rspec-rails is a testing framework for Rails 3.x and 4.x
  # https://github.com/rspec/rspec-rails
  gem 'rspec-rails', '~> 3.8'

  # complete suite of testing facilities supporting TDD, BDD, mocking, and benchmarking.
  # https://github.com/seattlerb/minitest
  gem 'minitest', '~> 5.11.3'

  # Minitest integration for Rails
  # https://github.com/blowmage/minitest-rails
  gem 'minitest-rails', '~> 3.0.0'

  # Capybara integration for Minitest and Rails.
  # https://github.com/blowmage/minitest-rails-capybara
  gem 'minitest-rails-capybara', '~> 3.0.1'

  # A Ruby library for mocking and stubbing.
  # https://github.com/freerange/mocha
  gem 'mocha', '~> 1.7.0'

  # A Ruby gem to load environment variables from `.env`.
  # https://github.com/bkeepers/dotenv
  gem 'dotenv-rails', '~>  2.5.0'

  # Collection of testing matchers extracted from Shoulda
  # https://github.com/thoughtbot/shoulda-matchers
  gem 'shoulda-matchers', '~> 3.0'

  # Makes tests easy on the fingers and the eyes
  # https://github.com/thoughtbot/shoulda
  gem 'shoulda', '~> 3.5'

  # OpenStruct subclass that returns nested hash attributes as RecursiveOpenStructs
  # https://github.com/aetherknight/recursive-open-struct
  gem 'recursive-open-struct', '~> 1.1.0'

  # A static analysis security vulnerability scanner for Ruby on Rails applications
  # https://github.com/presidentbeef/brakeman
  gem 'brakeman'

  # Generate Entity-Relationship Diagrams for Rails applications
  # https://github.com/voormedia/rails-erd
  gem 'rails-erd'
end

group :development do
  # Annotate ActiveRecord models as a gem
  # https://github.com/ctran/annotate_models
  gem 'annotate'

  # Preview mail in the browser instead of sending.
  # https://github.com/ryanb/letter_opener
  gem 'letter_opener'

  # Access an IRB console on exception pages or by using <%= console %>
  # anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  # gem 'spring'
  # gem 'spring-watcher-listen', '~> 2.0.0'

  # Code coverage
  # https://github.com/colszowka/simplecov
  gem 'simplecov', require: false

  # help to kill N+1 queries and unused eager loading
  # https://github.com/flyerhzm/bullet
  gem 'bullet'

  gem 'haml-lint'

  gem 'derailed'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

# Rollbar capture and report errors in your applications
gem 'rollbar'

# replace the standard rails page error
# https://github.com/charliesome/better_errors
gem 'better_errors'
# Retrieve the binding of a methods caller MRI
# https://github.com/banister/binding_of_caller
gem 'binding_of_caller'

# Performance dashboard for postgresql
# https://github.com/ankane/pghero/blob/master/guides/Rails.md#pghero-for-rails
gem 'pghero'
gem 'pg_query', '>= 0.9.0'

gem 'bootstrap-sass', '~> 3.3.7'
gem 'bootstrap-social-rails', '~> 4.12.0'
gem 'will_paginate-bootstrap', '~> 1.0.1'
gem 'date_validator'

# intl-tel-input for the Rails asset pipeline
# https://github.com/ispyropoulos/intl-tel-input-rails
gem 'intl-tel-input-rails'

# Immigrant gives Rails a foreign key migration generator
# https://github.com/jenseng/immigrant
gem 'immigrant'

gem 'puma_worker_killer'

group :staging, :production do
  # Log outgoing HTTP requests in ruby
  gem 'httplog'
end

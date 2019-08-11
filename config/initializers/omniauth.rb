# frozen_string_literal: true

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :linkedin,
           ENV['LINKED_IN_APP_ID'],
           ENV['LINKED_IN_SECRET']

  provider :facebook,
           ENV['FACEBOOK_APP_ID'],
           ENV['FACEBOOK_SECRET'],
           scope: 'email, user_link',
           display: 'popup',
           info_fields: 'email, first_name, last_name'
end

# frozen_string_literal: true

FactoryBot.define do
  factory :access_token do
    provider 'MyString'
    token 'MyString'
    expires_at 'MyString'
    expires false
  end
end

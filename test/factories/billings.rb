# frozen_string_literal: true

FactoryBot.define do
  factory :billing do
    user nil
    street 'MyString'
    city 'MyString'
    state 'MyString'
    zip 'MyString'
    country 'MyString'
  end
end

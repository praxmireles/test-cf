# frozen_string_literal: true

FactoryBot.define do
  factory :contact_information do
    user nil
    primary_phone 'MyString'
    secondary_phone 'MyString'
    primary_mobile 'MyString'
    secondary_mobile 'MyString'
  end
end

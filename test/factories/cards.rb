# frozen_string_literal: true

FactoryBot.define do
  factory :card do
    stripe_card_uid 'MyString'
    stripe_card_brand 'MyString'
    stripe_card_last4 'MyString'
    stripe_card_exp_month 'MyString'
    stripe_card_exp_year 'MyString'
  end
end

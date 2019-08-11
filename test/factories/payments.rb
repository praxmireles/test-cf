# frozen_string_literal: true

FactoryBot.define do
  factory :payment do
    amount { '1.0' }
    card_last4 { '1234' }
    brand { 'VISA' }
    exp_month { '12' }
    exp_year { '89' }
  end
end

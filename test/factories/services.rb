# frozen_string_literal: true

FactoryBot.define do
  factory :service do
    type 'ProjectInMind'
    duration_in_min 6
    price 57.0
  end
end

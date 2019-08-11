# frozen_string_literal: true

FactoryBot.define do
  factory :notification do
    user nil
    message 'MyText'
  end
end

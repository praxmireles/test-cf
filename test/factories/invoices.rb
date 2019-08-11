# frozen_string_literal: true

FactoryBot.define do
  factory :invoice do
    user nil
    expert_id 1
    payment nil
    date '2018-08-10 20:06:40'
    due_date '2018-08-10 20:06:40'
  end
end

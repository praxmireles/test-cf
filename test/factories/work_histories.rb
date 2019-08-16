# frozen_string_literal: true

FactoryBot.define do
  factory :work_history do
    user nil
    title 'MyString'
    company 'MyString'
    location 'MyString'
    from_date '2018-08-10 20:05:56'
    to_date '2018-08-10 20:05:56'
    present false
  end
end

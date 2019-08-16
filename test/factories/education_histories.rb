# frozen_string_literal: true

FactoryBot.define do
  factory :education_history do
    user nil
    degree 'MyString'
    field_of_study 'MyString'
    from_date '2018-08-10 20:05:19'
    to_date '2018-08-10 20:05:19'
    present false
  end
end

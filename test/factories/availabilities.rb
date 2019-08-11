# frozen_string_literal: true

FactoryBot.define do
  factory :availability do
    trait :monday do
      day_of_week { 'Monday' }
    end
    trait :tuesday do
      day_of_week { 'Tuesday' }
    end
    trait :wednesday do
      day_of_week { 'Wednesday' }
    end
    trait :thursday do
      day_of_week { 'Thursday' }
    end
    trait :friday do
      day_of_week { 'Friday' }
    end
    trait :saturday do
      day_of_week { 'Saturday' }
    end
    trait :sunday do
      day_of_week { 'Sunday' }
    end

    trait :morning do
      start_time { '08:00' }
      end_time { '09:00' }
    end

    trait :noon do
      start_time { '12:30' }
      end_time { '13:00' }
    end

    trait :afternoon do
      start_time { '14:30' }
      end_time { '15:30' }
    end

    trait :night do
      start_time '19:00'
      end_time '20:30'
    end

    factory :available_monday_morning, traits: %i[monday morning]
    factory :available_monday_noon, traits: %i[monday noon]
    factory :available_monday_afternoon, traits: %i[monday afternoon]
    factory :available_monday_night, traits: %i[monday night]

    factory :available_tuesday_morning, traits: %i[tuesday morning]
    factory :available_tuesday_noon, traits: %i[tuesday noon]
    factory :available_tuesday_afternoon, traits: %i[tuesday afternoon]
    factory :available_tuesday_night, traits: %i[tuesday night]

    factory :available_wednesday_morning, traits: %i[wednesday morning]
    factory :available_wednesday_noon, traits: %i[wednesday noon]
    factory :available_wednesday_afternoon, traits: %i[wednesday afternoon]
    factory :available_wednesday_night, traits: %i[wednesday night]

    factory :available_thursday_morning, traits: %i[thursday morning]
    factory :available_thursday_noon, traits: %i[thursday noon]
    factory :available_thursday_afternoon, traits: %i[thursday afternoon]
    factory :available_thursday_night, traits: %i[thursday night]

    factory :available_friday_morning, traits: %i[friday morning]
    factory :available_friday_noon, traits: %i[friday noon]
    factory :available_friday_afternoon, traits: %i[friday afternoon]
    factory :available_friday_night, traits: %i[friday night]

    factory :available_saturday_morning, traits: %i[saturday morning]
    factory :available_saturday_noon, traits: %i[saturday noon]
    factory :available_saturday_afternoon, traits: %i[saturday afternoon]
    factory :available_saturday_night, traits: %i[saturday night]

    factory :available_sunday_morning, traits: %i[sunday morning]
    factory :available_sunday_noon, traits: %i[sunday noon]
    factory :available_sunday_afternoon, traits: %i[sunday afternoon]
    factory :available_sunday_night, traits: %i[sunday night]
  end
end

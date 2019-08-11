# frozen_string_literal: true

FactoryBot.define do
  factory :user do
  end

  factory :expert, parent: :user, class: 'Expert' do
    first_name { 'Test' }
    last_name { 'Joe' }
    username { 'testjoe' }
    active true
    sequence :email do |n|
      "expert#{n}@example.com"
    end
    job { 'MyString' }
    company { 'MyString' }
    facebook_url { 'http://facebook.com/test' }
    google_url { 'http://google.com/test' }
    linkedin_url { 'http://linkedin.com/in/test' }
    avatar { 'MyString' }
    provider { 'linkedin' }
    stripe_customer_id { '123stripe' }
    accepted_privacy_policy { false }
    accepted_policy_on { '2018-08-10 20:04:13' }
    facebook_uid { '12345facebook' }
    linkedin_uid { '12345linkedin' }
    completed_onboarding { false }
    location { 'Toronto' }
    timezone_id { 1 }
    coach { false }

    # user_with_posts will create post data after the user has been created
    factory :expert_with_availabilities do
      # posts_count is declared as a transient attribute and available in
      # attributes on the factory, as well as the callback via the evaluator
      # transient do
      #   availabilities_count { 5 }
      # end

      # the after(:create) yields two values; the user instance itself and the
      # evaluator, which stores all values from the factory, including transient
      # attributes; `create_list`'s second argument is the number of records
      # to create and we make sure the user is associated properly to the post
      after(:create) do |user, _evaluator|
        availabilities_one = [
          # :available_monday_morning,
          :available_monday_noon,
          :available_monday_afternoon,
          :available_monday_night,
          # :available_tuesday_morning,
          # :available_tuesday_noon,
          # :available_tuesday_afternoon,
          # :available_tuesday_night,
          :available_wednesday_morning,
          :available_wednesday_noon,
          :available_wednesday_afternoon,
          :available_wednesday_night,
          :available_thursday_morning,
          # :available_thursday_noon,
          # :available_thursday_afternoon,
          # :available_thursday_night,
          :available_friday_morning,
          :available_friday_noon,
          :available_friday_afternoon,
          :available_friday_night,
          # :available_saturday_morning,
          # :available_saturday_noon,
          # :available_saturday_afternoon,
          # :available_saturday_night,
          # :available_sunday_morning,
          # :available_sunday_noon,
          # :available_sunday_afternoon,
          # :available_sunday_night,
        ]

        availabilities_two = [
          # :available_monday_morning,
          :available_monday_noon,
          :available_monday_afternoon,
          :available_monday_night,
          # :available_tuesday_morning,
          :available_tuesday_noon,
          :available_tuesday_afternoon,
          :available_tuesday_night,
          # :available_wednesday_morning,
          :available_wednesday_noon,
          :available_wednesday_afternoon,
          :available_wednesday_night,
          # :available_thursday_morning,
          # :available_thursday_noon,
          # :available_thursday_afternoon,
          # :available_thursday_night,
          # :available_friday_morning,
          # :available_friday_noon,
          # :available_friday_afternoon,
          # :available_friday_night,
          # :available_saturday_morning,
          # :available_saturday_noon,
          # :available_saturday_afternoon,
          # :available_saturday_night,
          # :available_sunday_morning,
          # :available_sunday_noon,
          # :available_sunday_afternoon,
          # :available_sunday_night,
        ]

        [availabilities_one, availabilities_two].sample.each do |availability|
          create_list(availability, 1, user: user)
        end
      end
    end

    # factory :expert_with_apppointments do
    #   after(:create) do |user, _evaluator|
    #     create_list(:open_appointment, 5, user: user)
    #     create_list(:in_progress_appointment, 5, user: user)
    #     create_list(:scheduled_appointment, 5, user: user)
    #     create_list(:cancelled_appointment, 5, user: user)
    #     create_list(:completed_appointment, 5, user: user)
    #   end
    # end
  end

  factory :client, parent: :user, class: 'Client' do
    first_name 'Test'
    last_name 'Joe'
    username 'testjoe'
    active true
    sequence :email do |n|
      "client#{n}@example.com"
    end
    job 'MyString'
    company 'MyString'
    facebook_url 'http://facebook.com/test'
    google_url 'http://google.com/test'
    linkedin_url 'http://linkedin.com/in/test'
    avatar 'MyString'
    provider 'linkedin'
    stripe_customer_id '123stripe'
    accepted_privacy_policy false
    accepted_policy_on '2018-08-10 20:04:13'
    facebook_uid '12345facebook'
    linkedin_uid '12345linkedin'
    completed_onboarding false
    location 'Toronto'
    timezone_id 1
    coach false

    factory :client_with_apppointments do
      after(:create) do |user, _evaluator|
        expert = create(:expert)
        service = create(:service)

        create(
          :open_appointment,
          client: user,
          expert: expert,
          service: service,
          request: create(:accepted_request, client: user, expert: expert),
          search_history: create(:search_history, client: user)
        )
        create(
          :in_progress_appointment,
          client: user,
          expert:  create(:expert),
          service: service,
          request: create(:accepted_request, client: user, expert: expert),
          search_history: create(:search_history, client: user),
          start_date: Time.now,
          end_date: 30.minutes.from_now
        )
        create(
          :scheduled_appointment,
          client: user,
          expert:  create(:expert),
          service: service,
          request: create(:accepted_request, client: user, expert: expert),
          search_history: create(:search_history, client: user)
        )
        create(
          :cancelled_appointment,
          client: user,
          expert:  create(:expert),
          service: service,
          request: create(:accepted_request, client: user, expert: expert),
          search_history: create(:search_history, client: user)
        )
        create(
          :completed_appointment,
          client: user,
          expert:  create(:expert),
          service: service,
          request: create(:accepted_request, client: user, expert: expert),
          search_history: create(:search_history, client: user)
        )
      end
    end
  end
end

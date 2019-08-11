# frozen_string_literal: true

FactoryBot.define do
  factory :appointment do
    service_id 1
    transient do
      first_available { 1 }
    end

    video_session_uid 'MyString'
    video_session_token 'MyString'
    description 'MyString'
    stripe_charge_uid 'MyString'
    subject 'MyString'
    offline { false }
    start_date { 2.days.from_now }
  end

  factory :open_appointment,
          parent: :user,
          class: 'OpenAppointment' do
    start_date { 2.days.from_now }
  end

  factory :scheduled_appointment,
          parent: :user,
          class: 'ScheduledAppointment' do
    scheduled_on { Time.parse('2018-08-10 20:07:54') }
    start_date { 2.days.from_now }
    factory :scheduled_intro_appointment do
      introduction { true }
      transient do
        client_id {}
        expert_id {}
        request_id {}
        service_id {}
        search_history_id {}
      end
    end
  end

  factory :in_progress_appointment,
          parent: :user, class: 'InProgressAppointment' do
    start_date { 2.days.from_now }
  end

  factory :cancelled_appointment,
          parent: :user, class: 'CancelledAppointment' do
    cancel_reason 'MyString'
    cancelled_on { Time.parse('2018-08-10 20:07:54') }
    cancelled { false }
    start_date { 2.days.from_now }

    transient do
      cancelled_by { 'Client' }
    end
  end

  factory :completed_appointment,
          parent: :user, class: 'CompletedAppointment' do
    time_spent_in_min { 60 }
    completed_on { Time.parse('2018-08-10 20:07:54') }
    start_date { 2.days.from_now }
  end

  factory :closed_appointment,
          parent: :user, class: 'CompletedAppointment' do
    time_spent_in_min { 60 }
    completed_on { Time.parse('2018-08-10 20:07:54') }
    start_date { 2.days.from_now }
    close_on { Time.now }
    close { true }
  end
end

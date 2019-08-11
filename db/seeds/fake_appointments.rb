# Create Fake Appointments for existing Clients
module FakeAppointments
  def create_express_advice_request(client, expert, start_date)
    puts '------ CREATE EXPRESS ADVICE REQUEST'
    search_params = {
      first_available: false,
      industry: 'Accounting',
      service: 'ExpressAdvice',
      functions: [JobFunction.first.id],
      skills: JobFunction.first.skills.first(3).pluck(:id),
      seniority_levels: SeniorityLevel.first(3).pluck(:id)
    }

    create_request_from_search_params(client, expert, search_params, start_date)
  end

  def create_mentoring_introduction_request(client, expert, start_date)
    puts '------ CREATE MENTORING INTRODUCTION REQUEST'
    search_params = {
      first_available: false,
      industry: 'Accounting',
      service: 'Mentoring',
      functions: [JobFunction.first.id],
      skills: JobFunction.first.skills.first(3).pluck(:id),
      seniority_levels: SeniorityLevel.first(3).pluck(:id)
    }

    create_request_from_search_params(client, expert, search_params, start_date)
  end

  def create_coaching_introduction_request(client, expert, start_date)
    puts '------ CREATE COACHING INTRODUCTION REQUEST'
    search_params = {
      first_available: false,
      industry: 'Accounting',
      service: 'Coaching',
      functions: [JobFunction.first.id],
      skills: JobFunction.first.skills.first(3).pluck(:id),
      seniority_levels: SeniorityLevel.first(3).pluck(:id),
      coaching_type: Coaching.coaching_types.first.id
    }

    create_request_from_search_params(client, expert, search_params, start_date)
  end

  def create_scheduled_mentoring_introduction_session(client, expert, start_date)
    puts '------ CREATE SCHEDULED MENTORING INTRODUCTION SESSION'
    search_params = {
      first_available: false,
      industry: 'Accounting',
      service: 'Mentoring',
      functions: [JobFunction.first.id],
      skills: JobFunction.first.skills.first(3).pluck(:id),
      seniority_levels: SeniorityLevel.first(3).pluck(:id)
    }

    pending_request = create_request_from_search_params(
      client, expert, search_params, start_date
    )
    if pending_request.accept!(skip: true)
      puts '-- ✅ Added Scheduled Mentoring Introduction Session'
    else
      puts '-- 🅾️ Failed to add Scheduled Mentoring Introduction Session'
    end
  end

  def create_scheduled_coaching_introduction_session(client, expert, start_date)
    puts '------ CREATE SCHEDULED COACHING INTRODUCTION SESSION'
    search_params = {
      first_available: false,
      industry: 'Accounting',
      service: 'Coaching',
      functions: [JobFunction.first.id],
      skills: JobFunction.first.skills.first(3).pluck(:id),
      seniority_levels: SeniorityLevel.first(3).pluck(:id)
    }

    pending_request = create_request_from_search_params(
      client, expert, search_params, start_date
    )

    if pending_request.accept!(skip: true)
      puts '-- ✅ Added Scheduled Coaching Introduction Session'
    else
      puts '-- 🅾️ Failed to add scheduled Coaching Introduction Session'
    end
  end

  def create_rejected_mentoring_introduction_session(client, expert, start_date)
    puts '------ CREATE REJECTED MENTORING INTRODUCTION SESSION'
    search_params = {
      first_available: false,
      industry: 'Accounting',
      service: 'Mentoring',
      functions: [JobFunction.first.id],
      skills: JobFunction.first.skills.first(3).pluck(:id),
      seniority_levels: SeniorityLevel.first(3).pluck(:id)
    }

    pending_request = create_request_from_search_params(
      client, expert, search_params, start_date
    )

    if pending_request.reject!
      puts '-- ✅ Added Rejected Mentoring Introduction Session'
    else
      puts '-- 🅾️ Failed to add Rejected mentoring Introduction Session'
    end
  end

  def create_rejected_coaching_introduction_session(client, expert, start_date)
    puts '------ CREATE REJECTED COACHING INTRODUCTION SESSION'
    search_params = {
      first_available: false,
      industry: 'Accounting',
      service: 'Coaching',
      functions: [JobFunction.first.id],
      skills: JobFunction.first.skills.first(3).pluck(:id),
      seniority_levels: SeniorityLevel.first(3).pluck(:id),
      coaching_type: Coaching.coaching_types.first
    }

    pending_request = create_request_from_search_params(
      client, expert, search_params, start_date
    )

    if pending_request.reject!
      puts '-- ✅ Added Rejected Coaching Introduction Session'
    else
      puts '-- 🅾️ Failed to add Rejected Coaching Introduction Session'
    end
  end

  def create_closed_mentoring_introduction_session(client, expert, start_date)
    puts '------ CREATE CLOSED MENTORING INTRODUCTION SESSION'
    search_params = {
      first_available: false,
      industry: 'Accounting',
      service: 'Mentoring',
      functions: [JobFunction.first.id],
      skills: JobFunction.first.skills.first(3).pluck(:id),
      seniority_levels: SeniorityLevel.first(3).pluck(:id)
    }

    pending_request = create_request_from_search_params(
      client, expert, search_params, start_date
    )

    if pending_request.cancel!
      puts '-- ✅ Added Closed Mentoring Introduction Session'
    else
      puts '-- 🅾️ Failed to add Closed mentoring Introduction Session'
    end
  end

  def create_closed_coaching_introduction_session(client, expert, start_date)
    puts '------ CREATE CLOSED COACHING INTRODUCTION SESSION'
    search_params = {
      first_available: false,
      industry: 'Accounting',
      service: 'Coaching',
      functions: [JobFunction.first.id],
      skills: JobFunction.first.skills.first(3).pluck(:id),
      seniority_levels: SeniorityLevel.first(3).pluck(:id),
      coaching_type: Coaching.coaching_types.first
    }

    pending_request = create_request_from_search_params(
      client, expert, search_params, start_date
    )

    if pending_request.cancel!
      puts '-- ✅ Added Closed Mentoring Introduction Session'
    else
      puts '-- 🅾️ Failed to add Closed mentoring Introduction Session'
    end
  end

  def create_in_progress_mentoring_introduction_session(
    client,
    expert,
    start_date
  )
    puts '------ CREATE IN PROGRESS MENTORING INTRODUCTION SESSION'
    search_params = {
      first_available: false,
      industry: 'Accounting',
      service: 'Mentoring',
      functions: [JobFunction.first.id],
      skills: JobFunction.first.skills.first(3).pluck(:id),
      seniority_levels: SeniorityLevel.first(3).pluck(:id)
    }

    pending_request = create_request_from_search_params(
      client, expert, search_params, start_date
    )

    pending_request.accept!(skip: true)
    if pending_request.appointment.present?
      scheduled_appointment = Appointment.find(
        pending_request.appointment.id
      )
    end

    if scheduled_appointment&.start!
      puts '-- ✅ Added In Progress Mentoring Introduction Session'
    else
      puts '-- 🅾️ Failed to add In Progress mentoring Introduction Session'
    end
  end

  def create_in_progress_coaching_introduction_session(
    client,
    expert,
    start_date
  )
    puts '------ CREATE IN PROGRESS COACHING INTRODUCTION SESSION'
    search_params = {
      first_available: false,
      industry: 'Accounting',
      service: 'Coaching',
      functions: [JobFunction.first.id],
      skills: JobFunction.first.skills.first(3).pluck(:id),
      seniority_levels: SeniorityLevel.first(3).pluck(:id)
    }

    pending_request = create_request_from_search_params(
      client, expert, search_params, start_date
    )

    pending_request.accept!(skip: true)
    if pending_request.appointment.present?
      scheduled_appointment = Appointment.find(
        pending_request.appointment.id
      )
    end

    if scheduled_appointment&.start!
      puts '-- ✅ Added In Progress Coaching Introduction Session'
    else
      puts '-- 🅾️ Failed to add In Progress Coaching  Introduction Session'
    end
  end

  def create_completed_mentoring_introduction_session(
    client,
    expert,
    start_date
  )
    puts '------ CREATE IN PROGRESS COACHING INTRODUCTION SESSION'
    search_params = {
      first_available: false,
      industry: 'Accounting',
      service: 'Coaching',
      functions: [JobFunction.first.id],
      skills: JobFunction.first.skills.first(3).pluck(:id),
      seniority_levels: SeniorityLevel.first(3).pluck(:id)
    }

    pending_request = create_request_from_search_params(
      client, expert, search_params, start_date
    )

    pending_request.accept!(skip: true)
    if pending_request.appointment.present?
      scheduled_appointment = Appointment.find(
        pending_request.appointment.id
      )
    end

    if scheduled_appointment&.start!
      if InProgressAppointment.find(scheduled_appointment.id).complete!
        puts '-- ✅ Added Completed Mentoring Introduction Session'
      else
        puts '-- 🅾️ Failed to add Completed Mentoring Introduction Session'
      end
    else
      puts '-- 🅾️ Failed to add Completed Mentoring Introduction Session'
    end
  end

  def create_completed_coaching_introduction_session(client, expert, start_date)
    puts '------ CREATE IN PROGRESS COACHING INTRODUCTION SESSION'
    search_params = {
      first_available: false,
      industry: 'Accounting',
      service: 'Mentoring',
      functions: [JobFunction.first.id],
      skills: JobFunction.first.skills.first(3).pluck(:id),
      seniority_levels: SeniorityLevel.first(3).pluck(:id)
    }

    pending_request = create_request_from_search_params(
      client, expert, search_params, start_date
    )

    pending_request.accept!(skip: true)
    if pending_request.appointment.present?
      scheduled_appointment = Appointment.find(
        pending_request.appointment.id
      )
    end

    if scheduled_appointment&.start!
      if InProgressAppointment.find(scheduled_appointment.id).complete!
        puts '-- ✅ Added Completed Coaching Introduction Session'
      else
        puts '-- 🅾️ Failed to add Completed Coaching Introduction Session'
      end
    else
      puts '-- 🅾️ Failed to add Completed Coaching Introduction Session'
    end
  end

  def create_cancelled_by_expert_mentoring_introduction_session(
    client,
    expert,
    start_date
  )
    puts '------ CREATE IN CANCELLED BY EXPERT Mentoring INTRODUCTION SESSION'
    search_params = {
      first_available: false,
      industry: 'Accounting',
      service: 'Mentoring',
      functions: [JobFunction.first.id],
      skills: JobFunction.first.skills.first(3).pluck(:id),
      seniority_levels: SeniorityLevel.first(3).pluck(:id)
    }

    pending_request = create_request_from_search_params(
      client, expert, search_params, start_date
    )

    pending_request.accept!(skip: true)
    if pending_request.appointment.present?
      scheduled_appointment = Appointment.find(
        pending_request.appointment.id
      )
    end

    if scheduled_appointment&.cancel_by_expert!
      puts '-- ✅ Added Completed Cancelled by Expert Mentoring Introduction Session'
    else
      puts '-- 🅾️ Failed to add Cancelled by Expert Mentoring Introduction Session'
    end
  end

  def create_cancelled_by_client_mentoring_introduction_session(
    client, expert, start_date
  )
    puts '------ CREATE IN CANCELLED BY CLIENT MENTORING INTRODUCTION SESSION'
    search_params = {
      first_available: false,
      industry: 'Accounting',
      service: 'Mentoring',
      functions: [JobFunction.first.id],
      skills: JobFunction.first.skills.first(3).pluck(:id),
      seniority_levels: SeniorityLevel.first(3).pluck(:id)
    }

    pending_request = create_request_from_search_params(
      client, expert, search_params, start_date
    )

    pending_request.accept!(skip: true)
    if pending_request.appointment.present?
      scheduled_appointment = Appointment.find(
        pending_request.appointment.id
      )
    end

    if scheduled_appointment&.cancel_by_client!
      puts '-- ✅ Added Completed Cancelled By Client Mentoring Introduction Session'
    else
      puts '-- 🅾️ Failed to add Cancelled by Client Mentoring Introduction Session'
    end
  end

  def create_request_from_search_params(
    client,
    expert,
    search_params,
    start_date
  )
    search_history = client.search_histories.new(search_params)
    if search_history.save
      puts '-- ✅ Created Search History'
    else
      puts '-- 🅾️ Failed to Search History'
      puts "errors: #{search_history.errors.messages}"
    end
    service = Service.find_by(type: search_history.service)

    appointment_params = {
      expert_id: expert.id,
      client_id: client.id,
      service_id: service.id,
      start_date: start_date,
      search_history_id: search_history.id
    }

    appointment_request_params = {
      expert_id: expert.id,
      user_id: client.id,
      search_history_id: search_history.id
    }

    appointment_request = client.pending_requests.new(
      appointment_request_params
    )

    if appointment_request.save
      puts '-- ✅ Created Appointment Request'
      appointment_request.initialize_appointment!(appointment_params)
    else
      puts '-- 🅾️ Failed to Create Appointment Request'
      puts "errors: #{appointment_request.errors.messages}"
    end
    appointment_request
  end

  def create_expert
    puts '------ CREATE EXPERT'
    expert = Expert.find_or_initialize_by(
      email: 'expert_test@test.com',
      first_name: 'John 1',
      last_name: 'Doe',
      facebook_url: 'http://example.com'
    )

    if expert.save
      unless Rails.env.staging? || Rails.env.production?
        expert.update_attributes(remote_avatar_url: 'https://previews.123rf.com/images/4zevar/4zevar1604/4zevar160400009/55704192-avatar-profile-icon-man.jpg')
      end
      puts '-- ✅ Found or Created Expert'
    else
      puts '-- 🅾️ Failed to Found or create Expert'
      puts "errors: #{expert.errors.messages}"
    end

    puts '-- ✅ Creating Contact Information....'
    expert.build_contact_information(
      primary_phone: '647-123-1234',
      secondary_phone: '647-123-1234',
      primary_mobile: '647-123-1234',
      secondary_mobile: '647-123-1234'
    )

    puts '-- ✅ Creating Profile....'
    profile = expert.build_profile(
      resume: '',
      about: "Lorem Ipsum is simply dummy text of the printing and typesetting\
       industry. Lorem Ipsum has been the industry's standard dummy text ever\
        since the 1500s, when an unknown printer took a galley of type and \
        scrambled it to make a type specimen book."
    )

    job_function = JobFunction.first

    profile_job_function = profile.job_functions.new(
      job_function_id: job_function.id
    )

    if profile_job_function.save
      puts '-- ✅ Adding Profile JobFunction'
    else
      puts '-- 🅾️ Failed to add Profile JobFunction'
      puts "errors: #{profile_job_function.errors.messages}"
    end

    job_function.skills_name.first(3).each do |skill_name|
      puts "-- ✅ Adding Job Function's Skill: #{skill_name}..."
      profile.skills.create!(skill_id: Skill.find_by_name(skill_name).id)
    end

    SeniorityLevel.all.first(3).each do |seniority_level|
      puts "-- ✅ Adding SeniorityLevel: #{seniority_level.short_name}"
      profile.seniority_levels.create!(seniority_level_id: seniority_level.id)
    end

    Industry.all.first(3).each do |industry|
      puts "-- ✅ Adding Industry: #{industry.name}"
      profile.industries.create!(industry_id: industry.id)
    end

    puts '-- ✅ Adding Language'
    profile.languages.create!(language_id: Language.find_by_name('English').id)
    expert
  end
end

def create_expert_availabilities(expert_id)
  expert = Expert.find(expert_id)
  expert.availabilities.create!(
    day_of_week: 'Monday',
    start_time: '8:00',
    end_time: '8:30'
  )

  expert.availabilities.create!(
    day_of_week: 'Tuesday',
    start_time: '12:00',
    end_time: '12:30'
  )

  expert.availabilities.create!(
    day_of_week: 'Wednesday',
    start_time: '15:00',
    end_time: '16:00'
  )
end

# rubocop:disable Style/MixinUsage
include FakeAppointments
# rubocop:enable Style/MixinUsage
if Client.all.empty?
  puts '🅾️ No Client. Login with Facebook and create a \
    Client User'
end
Client.all.each do |client|
  puts 'Create Appointment for Expert'

  # Create Request
  expert = create_expert

  start_date = '8:00 AM'.to_datetime

  create_express_advice_request(client, expert, start_date)

  start_date += 8.hours

  create_mentoring_introduction_request(client, expert, start_date)

  start_date += 8.hours

  create_coaching_introduction_request(client, expert, start_date)

  start_date += 8.hours

  # Create Approved Request | ScheduledAppointment
  create_scheduled_mentoring_introduction_session(client, expert, start_date)

  start_date += 8.hours

  create_scheduled_coaching_introduction_session(client, expert, start_date)

  start_date += 8.hours

  # # Create Rejected Request | ClosedAppointment
  create_rejected_mentoring_introduction_session(client, expert, start_date)

  start_date += 8.hours

  create_rejected_coaching_introduction_session(client, expert, start_date)

  start_date += 8.hours

  # Create Closed Request | ClosedAppointment
  create_closed_mentoring_introduction_session(client, expert, start_date)

  start_date += 8.hours

  create_closed_coaching_introduction_session(client, expert, start_date)

  start_date += 8.hours

  # Create InProgress Appointment | InProgressAppointment
  create_in_progress_mentoring_introduction_session(client, expert, start_date)

  start_date += 8.hours

  create_in_progress_coaching_introduction_session(client, expert, start_date)

  start_date += 8.hours

  # # Create Completed Appointment
  create_completed_mentoring_introduction_session(client, expert, start_date)

  start_date += 8.hours

  create_completed_coaching_introduction_session(client, expert, start_date)

  start_date += 8.hours

  # # Create Cancelled Appointment
  create_cancelled_by_expert_mentoring_introduction_session(client, expert, start_date)

  start_date += 8.hours

  create_cancelled_by_client_mentoring_introduction_session(client, expert, start_date)
end

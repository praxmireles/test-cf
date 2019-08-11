# Create Fake Appointments for existing Clients
module FakeAppointmentPacks
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
      puts '-- ✅ Created Expert'
    else
      puts '-- 🅾️ Failed to create Expert'
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
    expert.profile.update_attributes(
      resume: '',
      about: "Lorem Ipsum is simply dummy text of the printing and typesetting\
       industry. Lorem Ipsum has been the industry's standard dummy text ever\
        since the 1500s, when an unknown printer took a galley of type and \
        scrambled it to make a type specimen book."
    )

    profile = expert.profile

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

  def create_scheduled_mentoring_appointment_pack(client, expert)
    puts '------ CREATE SCHEDULED MENTORING APPOINTMENT PACK'
    # start_dates = (1...8).map { |x| x.days.from_now }
    start_dates = [
      '10:00'.to_datetime,
      '10:00'.to_datetime + 1.day,
      '10:00'.to_datetime + 2.day,
      '10:00'.to_datetime + 3.day,
      '10:00'.to_datetime + 4.day,
      '10:00'.to_datetime + 5.day,
      '10:00'.to_datetime + 6.day,
      '10:00'.to_datetime + 7.day
    ]

    appointment_params = {
      user_id: client.id,
      expert_id: expert.id,
      description: 'this is going to be pretty good',
      name: "My Awesome Appointment Pack #{expert.id}",
      start_dates: start_dates,
      service_id: Service.find_by(type: 'Mentoring').id
    }

    appointment_pack = AppointmentPack.schedule_appointments(
      appointment_params
    )

    if appointment_pack.appointments.exists?
      puts "-- ✅ Created #{appointment_pack.appointments.count} Appointment Pack"
    else
      puts '-- 🅾️ Failed to create Appointment Pack'
    end
  end

  def create_scheduled_coaching_appointment_pack(client, expert)
    puts '------ CREATE SCHEDULED COACHING APPOINTMENT PACK'
    # start_dates = (1...8).map { |x| x.days.from_now }
    start_dates = [
      '12:00'.to_datetime,
      '12:00'.to_datetime + 1.day,
      '12:00'.to_datetime + 2.day,
      '12:00'.to_datetime + 3.day,
      '12:00'.to_datetime + 4.day,
      '12:00'.to_datetime + 5.day,
      '12:00'.to_datetime + 6.day,
      '12:00'.to_datetime + 7.day
    ]

    appointment_params = {
      user_id: client.id,
      expert_id: expert.id,
      description: 'this is going to be pretty good',
      name: "My Awesome Appointment Pack #{expert.id}",
      start_dates: start_dates,
      service_id: Service.find_by(type: 'Coaching').id,
      coaching_type: Coaching.coaching_types.first
    }

    appointment_pack = AppointmentPack.schedule_appointments(
      appointment_params
    )

    if appointment_pack.appointments.exists?
      puts "-- ✅ Created #{appointment_pack.appointments.count} Appointment Pack"
    else
      puts '-- 🅾️ Failed to create Appointment Pack'
    end
  end

  def create_in_progress_mentoring_appointment_pack(client, expert)
    puts '------ CREATE IN PROGRESS MENTORING APPOINTMENT PACK'
    # start_dates = (1...8).map { |x| x.days.from_now }
    start_dates = [
      '2:00'.to_datetime,
      '2:00'.to_datetime + 1.day,
      '2:00'.to_datetime + 2.day,
      '2:00'.to_datetime + 3.day,
      '2:00'.to_datetime + 4.day,
      '2:00'.to_datetime + 5.day,
      '2:00'.to_datetime + 6.day,
      '2:00'.to_datetime + 7.day
    ]

    appointment_params = {
      user_id: client.id,
      expert_id: expert.id,
      description: 'this is going to be pretty good',
      name: "My Awesome Appointment Pack #{expert.id}",
      start_dates: start_dates,
      service_id: Service.find_by(type: 'Mentoring').id
    }

    appointment_pack = AppointmentPack.schedule_appointments(
      appointment_params
    )

    if appointment_pack.appointments.exists?
      puts "-- ✅ Created #{appointment_pack.appointments.count} Appointment Pack"
    else
      puts '-- 🅾️ Failed to create Appointment Pack'
    end

    appointment_pack.appointments.first.start!
  end

  def create_in_progress_coaching_appointment_pack(client, expert)
    puts '------ CREATE IN PROGRESS MENTORING APPOINTMENT PACK'
    start_dates = (1...8).map { |x| x.days.from_now }

    appointment_params = {
      user_id: client.id,
      expert_id: expert.id,
      description: 'this is going to be pretty good',
      name: "My Awesome Appointment Pack #{expert.id}",
      start_dates: start_dates,
      service_id: Service.find_by(type: 'Coaching').id
    }

    appointment_pack = AppointmentPack.schedule_appointments(
      appointment_params
    )

    if appointment_pack.appointments.exists?
      puts "-- ✅ Created #{appointment_pack.appointments.count} Appointment Pack"
    else
      puts '-- 🅾️ Failed to create Appointment Pack'
    end

    appointment_pack.appointments.first.start!
  end

  def create_completed_mentoring_appointment_pack(client, expert)
    puts '------ CREATE IN PROGRESS MENTORING APPOINTMENT PACK'
    # start_dates = (1...8).map { |x| x.days.from_now }
    start_dates = [
      '15:00'.to_datetime,
      '15:00'.to_datetime + 1.day,
      '15:00'.to_datetime + 2.day,
      '15:00'.to_datetime + 3.day,
      '15:00'.to_datetime + 4.day,
      '15:00'.to_datetime + 5.day,
      '15:00'.to_datetime + 6.day,
      '15:00'.to_datetime + 7.day
    ]

    appointment_params = {
      user_id: client.id,
      expert_id: expert.id,
      description: 'this is going to be pretty good',
      name: "My Awesome Appointment Pack #{expert.id}",
      start_dates: start_dates,
      service_id: Service.find_by(type: 'Mentoring').id
    }

    appointment_pack = AppointmentPack.schedule_appointments(
      appointment_params
    )

    if appointment_pack.appointments.exists?
      puts "-- ✅ Created #{appointment_pack.appointments.count} Appointment Pack"
    else
      puts '-- 🅾️ Failed to create Appointment Pack'
    end

    appointment_pack.appointments.each do |appointment|
      appointment.start!
      InProgressAppointment.find(appointment.id).complete!
    end
  end

  def create_completed_coaching_appointment_pack(client, expert)
    puts '------ CREATE COMPLETED MENTORING APPOINTMENT PACK'
    # start_dates = (1...8).map { |x| x.days.from_now }
    start_dates = [
      '16:00'.to_datetime,
      '16:00'.to_datetime + 1.day,
      '16:00'.to_datetime + 2.day,
      '16:00'.to_datetime + 3.day,
      '16:00'.to_datetime + 4.day,
      '16:00'.to_datetime + 5.day,
      '16:00'.to_datetime + 6.day,
      '16:00'.to_datetime + 7.day
    ]

    appointment_params = {
      user_id: client.id,
      expert_id: expert.id,
      description: 'this is going to be pretty good',
      name: "My Awesome Appointment Pack #{expert.id}",
      start_dates: start_dates,
      service_id: Service.find_by(type: 'Coaching').id
    }

    appointment_pack = AppointmentPack.schedule_appointments(
      appointment_params
    )

    if appointment_pack.appointments.exists?
      puts "-- ✅ Created #{appointment_pack.appointments.count} Appointment Pack"
    else
      puts '-- 🅾️ Failed to create Appointment Pack'
    end

    appointment_pack.appointments.each do |appointment|
      appointment.start!
      InProgressAppointment.find(appointment.id).complete!
    end
  end
end

# rubocop:disable Style/MixinUsage
include FakeAppointmentPacks
# rubocop:enable Style/MixinUsage
if Client.all.empty?
  puts '🅾️ No Client. Login with Facebook and create a \
    Client User'
end
Client.all.each do |client|
  puts 'Create Appointment for Expert'

  # Create Request
  expert = create_expert

  # Create Scheduled 5 Session Mentoring
  create_scheduled_mentoring_appointment_pack(client, expert)
  create_scheduled_coaching_appointment_pack(client, expert)

  # Create In Progress Appointment Pack
  create_in_progress_mentoring_appointment_pack(client, expert)
  create_in_progress_coaching_appointment_pack(client, expert)

  # Create Completed Appointment Pack
  create_completed_mentoring_appointment_pack(client, expert)
  create_completed_coaching_appointment_pack(client, expert)
end

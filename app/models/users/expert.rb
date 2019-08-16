# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                      :bigint(8)        not null, primary key
#  type                    :string
#  first_name              :string
#  last_name               :string
#  username                :string
#  active                  :boolean          default(FALSE)
#  email                   :string
#  job                     :string
#  company                 :string
#  facebook_url            :string
#  google_url              :string
#  linkedin_url            :string
#  avatar                  :string
#  provider                :string
#  stripe_customer_id      :string
#  hourly_rate             :float
#  accepted_privacy_policy :boolean          default(FALSE)
#  accepted_policy_on      :datetime
#  facebook_uid            :string
#  linkedin_uid            :string
#  completed_onboarding    :boolean          default(FALSE)
#  location                :string
#  timezone_id             :integer
#  coach                   :boolean          default(FALSE)
#  last_sign_in_ip         :string
#  current_sign_in_ip      :string
#  last_sign_in_at         :datetime
#  sign_in_count           :integer
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  current_card_id         :integer
#

require_dependency 'timeable'
require_dependency 'notificable'
require_dependency 'user'
class Expert < User
  include Timeable
  include Notificable

  has_paper_trail

  has_one :profile, foreign_key: :user_id, dependent: :destroy

  has_many :education_histories, foreign_key: :user_id, dependent: :destroy
  has_many :work_histories, foreign_key: :user_id, dependent: :destroy
  has_many :career_highlights, foreign_key: :user_id, dependent: :destroy
  has_many :industry_experiences, foreign_key: :user_id, dependent: :destroy
  has_many :invoices, foreign_key: :user_id, dependent: :destroy
  has_many :services, class_name: 'UsersService', foreign_key: :user_id,
                      dependent: :destroy
  has_many :industries, through: :profile
  has_many :skills, through: :profile
  has_many :job_functions, through: :profile
  has_many :seniority_levels, through: :profile
  has_many :languages, through: :profile

  has_many :appointments, foreign_key: :expert_id

  has_many :open_appointments,
           foreign_key: :expert_id,
           dependent: :destroy
  has_many :scheduled_appointments,
           foreign_key: :expert_id,
           dependent: :destroy
  has_many :in_progress_appointments,
           foreign_key: :expert_id,
           dependent: :destroy
  has_many :cancelled_appointments,
           foreign_key: :expert_id,
           dependent: :destroy
  has_many :completed_appointments,
           foreign_key: :expert_id,
           dependent: :destroy
  has_many :closed_appointments,
           foreign_key: :expert_id,
           dependent: :destroy

  has_many :accepted_requests, foreign_key: :expert_id, dependent: :destroy
  has_many :rejected_requests, foreign_key: :expert_id, dependent: :destroy
  has_many :pending_requests, foreign_key: :expert_id, dependent: :destroy
  has_many :cancelled_requests, foreign_key: :expert_id, dependent: :destroy
  has_many :failed_payouts, foreign_key: :expert_id, dependent: :destroy
  # has_many :contact_informations, class_name: 'ContactInformation',
  #                                 foreign_key: :user_id, dependent: :delete_all
  has_one :balance, foreign_key: :user_id, dependent: :delete
  has_one :business_information

  HOURS = ['Morning (8:00 - 11:00 AM)', 'Noon(11:00 AM - 1:00 PM)',
           'Afternon(1:00 - 6:00 PM)', 'Night(6:00 - 9:00 PM)',
           'Latenight(9:00 PM - 00:00 AM)'].freeze

  after_create :create_expert_profile
  after_create :set_balance

  def in_timezone(time)
    if timezone.present?
      time.in_time_zone(-6)
    else
      time.in_time_zone(timezone.utc_difference)

    end
  end

  def self.hours
    HOURS
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def create_expert_profile
    create_profile!
  end

  def set_balance
    build_balance
    save
  end

  def notification
    @notifications = current_user.notifications
  end

  def profile_summary
    {
      industries: industries.map { |x| x.industry.name },
      skills: skills.map { |x| x.skill.name },
      job_functions: job_functions.map { |x| x.job_function.name },
      languages: languages.map { |x| x.language.name },
      seniority_levels: seniority_levels.map { |x| x.seniority_level.name }
    }
  end

  # An array that match a search query from params
  #
  # Params:
  # - service [String]: Name of the service
  # - industry [String]: Name of the Industry
  # - job_functions [Array]: A list of job_functions name
  # - seniority_levels [Array]: A list of seniority levels name
  # - skills [Array]: A list of skills name
  # - first_available [Boolean]
  #
  # Returns [Array]
  def self.find_match(params)
    if params[:service]
      service_id = Service.find_by_type(params[:service])&.id

      service_matches = UsersService.where(
        service_id: service_id
      ).map(&:user)
    else
      service_matches = []
    end

    if params[:industry]
      industry_id = Industry.find_by_name(params[:industry])&.id

      industries_matches = ProfileIndustry.where(
        industry_id: industry_id
      ).map { |x| x.profile.expert }
    else
      industries_matches = []
    end

    if params[:job_functions]
      job_function_ids = params[:job_functions].map do |job_function|
        JobFunction.find_by_name(job_function)&.id
      end

      job_functions_matches = ProfileJobFunction.where(
        job_function_id: job_function_ids
      ).map { |x| x.profile.expert }
    else
      job_functions_matches = []
    end

    if params[:seniority_levels]
      seniority_level_ids = params[:seniority_levels].map do |seniority_level|
        SeniorityLevel.find_by_name(seniority_level)&.id
      end

      seniority_levels_matches = ProfileSeniorityLevel.where(
        seniority_level_id: seniority_level_ids
      ).map { |x| x.profile.expert }
    else
      seniority_levels_matches = []
    end

    if params[:skills]
      skill_ids = params[:skills].map do |skill_id|
        skill_id
      end
      skills_matches = ProfileSkill.where(
        skill_id: skill_ids
      ).map { |x| x.profile.expert }
    else
      skills_matches = []
    end

    intersection =  skills_matches |
                    industries_matches |
                    job_functions_matches |
                    seniority_levels_matches |
                    service_matches

    intersection = order_by_first_available(intersection) if params[:first_available] == true

    intersection
  end

  # Order an array of expert by first_available
  #
  # Params:
  # - experts_array: An array of Expert
  #
  # Returns [Array]
  def self.order_by_first_available(experts_array)
    experts = []
    next_7_days.each do |date|
      find_available_experts_today(experts_array, date).each do |expert|
        experts << expert unless experts.include? expert
      end
    end
    experts
  end

  # Expert usual availabilities  and booking on a given date
  #
  # Params
  # - date [String]: format "%d/%m/%Y"
  #    example: '11/19/2018'
  #
  # Returns an array of time:
  #  eg: array
  def availabilities_booking_for(date)
    schedule_availabilities = availabilities.map do |availability|
      availability.start_time + '   -   ' + availability.end_time if availability.day_of_week.casecmp(Date.parse(
        date
      ).strftime('%A')).zero?
    end

    schedule_booking = appointments.all.map do |appointment|
      time_start = appointment.start_date.strftime('%H:%M')
      time_end = appointment.start_date.strftime('%H:%M')
      next unless appointment.start_date.strftime('%d/%m/%Y') == date
      in_timezone(time_start).strftime('%H:%M') + '   -   ' +
        in_timezone(time_end).strftime('%H:%M') + ' ' +
        appointment.client.last_name + ',' +
        appointment.client.first_name + ' <br>' +
        appointment.search_history.service + ': ' +
        appointment.search_history.description[0...40] + '...'
    end

    h_result = {}
    schedule_availabilities.map do |ele|
      h_result[{ 'start_time' => ele }] = true
    end
    schedule_availabilities_booking_for = h_result
    schedule_booking.map do |ele|
      h_result[{ 'start_time' => ele }] = false
    end

    h_result.delete_if { |key, _value| key == { 'start_time' => nil } }
    schedule_availabilities_booking_for.merge(h_result).to_a
  end

  # Expert usual availabilities on a given date
  #
  # Params
  # - date [String]: format "%d/%m/%Y"
  #    example: '11/19/2018'
  #
  # Returns an array of time:
  #  eg: ["8:00", "12:00"]
  def availabilities_for(date)
    availables = availabilities.select { |a| a.day_of_week.casecmp(Date.parse(date).strftime('%A')).zero? }

    schedule_availabilities = availables.map do |a|
      a.start_time.in_time_zone('UTC').strftime('%H:%M')
    end

    schedule_availabilities
  end

  # Expert booking on a given date
  #
  # Params
  # - date [String]: format "%d/%m/%Y"
  #    example: '11/19/2018'
  #
  # Returns an array of time:
  #  eg: ["8:00", "12:00"]
  def bookings_for(date)
    appointments_for_date = appointments.all.map do |appointment|
      time = appointment.start_date.strftime('%H:%M')
      in_timezone(time).strftime('%H:%M') if \
        appointment.start_date.strftime('%d/%m/%Y') == date
    end
    appointments_for_date
  end

  # Expert schedule on a given date (booking and available booking)
  #
  # Params
  # - date [String]: format "%d/%m/%Y"
  #    example: '11/19/2018'
  #
  # Returns [Array] of time:
  #  eg: ["8:00", "12:00"]
  def open_time_slots(date)
    if availabilities_for(date).present? && bookings_for(date).present?
      availabilities_for(date) - (availabilities_for(date) - bookings_for(date))
    else
      availabilities_for(date)
    end
  end

  # Return the available schedule of a user between two date
  # To be used with a calendar to get the user schedule
  #
  # Return [Hash]
  #   e.g: {"11/19/2018" => ['10:00'], "11/20/2018" => [9:00]}
  def schedule_betwen_dates(from_date, to_date)
    date_range = (from_date.to_date...to_date.to_date)
    date_range_array = date_range.map do |date|
      date.strftime('%d/%m/%Y')
    end

    date_range_schedule = {}

    date_range_array.each do |date|
      time_slots = open_time_slots(date)
      date_range_schedule[date] = time_slots unless time_slots.empty?
    end
    date_range_schedule
  end

  # Return an array of bookings from User's Scheduled Appointment
  #
  # Return [Array] of [DateTime]
  # strftime: '%d/%m/%Y'
  def scheduled_appointments_start_dates(strftime)
    scheduled_appointments.map do |a|
      a.start_date.strftime(strftime)
    end
  end

  # Return the expert availabilities for the given datetime
  #
  # Return [Boolean]
  def available_for_datetime(datetime)
    if scheduled_appointments_start_dates('%d/%m/%Y').include? datetime
      false
    else
      true
    end
  end

  def next_availabilities
    schedule_betwen_dates(
      Date.today.strftime('%d/%m/%Y'),
      7.days.from_now.strftime('%d/%m/%Y')
    )
  end

  def next_availability
    schedule_betwen_dates(
      Date.today.strftime('%d/%m/%Y'),
      7.days.from_now.strftime('%d/%m/%Y')
    ).first
  end

  # Return an hash of boolean value for a given array of datetimes
  # Can be used to verivy the ability of a user for a list of dates
  #
  # Return [Hash]
  def available_for_datetimes(datetimes_array)
    availability_hash = {}
    datetimes_array.each do |datetime|
      availability_hash[datetime] = available_for_datetime(datetime)
    end
    availability_hash
  end

  # List of all the available experts for the given day of the week and expet
  # array
  #
  # Params:
  # - expert_array: array of Expert
  # - date [String]: format "%d/%m/%Y"
  #     example: '11/19/2018'
  #
  # Returns [Array]
  def self.find_available_experts_today(experts_array, date)
    today_experts = experts_array.select do |e|
      e.open_time_slots(date).any?
    end

    sorted_experts = today_experts.sort_by do |expert|
      [expert.open_time_slots(date).first]
    end

    sorted_experts
  end

  # The shedule of an expert for the current week Sunday-Saturday
  #
  # Returns [Array]
  def this_week_schedule
    schedule = {}
    (
      Date.today.beginning_of_week...Date.today.end_of_week
    ).each do |date, _index|
      availabilities = availabilities_for(date.strftime('%d/%m/%Y'))
      schedule[date] = availabilities if availabilities.any?
    end
    schedule
  end

  def available_days_this_week
    schedule = []
    (
      Date.today.beginning_of_week...Date.today.end_of_week
    ).each do |date, _index|
      schedule << date if availabilities_for(date.strftime('%d/%m/%Y'))
    end
    schedule
  end

  def availabilities_today_to_next_week(strftime)
    # Date.today...Date.today.next_week(Date.today.strftime('%A')
    availabilities_hash = availability_date_range(
      Date.today,
      Date.today.next_week(Date.today.strftime('%A').downcase.to_sym)
    )

    availabilities_array = []

    availabilities_hash.each do |key, val|
      val.each do |v|
        availabilities_array << "#{key} at #{v}".to_date.strftime(strftime)
      end
    end

    availabilities_array
  end

  def availability_date_range(from_date, future_date)
    schedule = {}
    (from_date...future_date).each do |date, _index|
      availabilities = availabilities_for(date.strftime('%d/%m/%Y'))
      schedule[date] = availabilities if availabilities.any?
    end
    schedule
  end

  def this_month_schedule(from_date, future_date)
    strftime = '%d/%m/%Y'
    availabilities_hash = availability_date_range(
      from_date,
      future_date
    )
    availabilities_array = []
    availabilities_hash.each do |key, val|
      val.each do |v|
        availabilities_array << "#{key} at #{v}".to_date.strftime(strftime)
      end
    end
    availabilities_array
  end

  def completed_enrollment!
    self.completed_onboarding = true
    PendingApplicant.create!(user_id: id)
    save

    notify_user(:expert_enrollment,
                action: :expert_finished_enrollment,
                user_id: id)
  end

  def create_balance_item(appointment_id, is_from_pack: false)
    # debugger
    appointment = Appointment.find(appointment_id)

    set_balance if balance.blank?

    description_message = \
      "Expert Fullname: #{fullname}" \
      "Expert Id: #{id}" \
      "Client Fullname: #{appointment.client.fullname}" \
      "Client Id: #{appointment.client.id}" \
      "Appointment Id: #{appointment.id}" \
      "Apointment Start Date: #{appointment.start_date}}" \
      "MWP Fees: #{appointment.fees}"

    application_balance = ApplicationBalance.first_or_create!

    appointment_fees = if is_from_pack && appointment.appointment_packs
                         appointment.fees / appointment.appointment_packs.count
                       else
                         appointment.fees
                       end

    appointment_due_to_application = if is_from_pack && appointment.appointment_packs
                                       appointment.due_to_application / appointment.appointment_packs.count
                                     else
                                       appointment.due_to_application
                                     end

    application_balance.application_balance_items.create!(
      amount: appointment_due_to_application,
      paid: false,
      appointment_id: appointment_id,
      description: description_message,
      application_fees: appointment_fees
    )

    balance.balance_items.create!(
      user_id: id,
      amount: appointment.due_to_expert,
      paid: false,
      appointment_id: appointment_id,
      description: description_message,
      application_fees: appointment_fees
    )
  end
end

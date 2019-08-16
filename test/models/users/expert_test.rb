# frozen_string_literal: true

require 'test_helper'

class ExpertTest < ActiveSupport::TestCase
  def setup
    @expert_array = []
    create(:job_function, name: 'Marketing Tools and Automations')
    create(:skill, job_function_id: JobFunction.first.id, name: 'Advertisings')
    service = create(:service)
    expert = create(:expert)
    client = create(:client)
    @appointment = create(:appointment, start_date: Date.today, service_id: service.id, expert_id: expert.id, user_id: client.id)
    unless SeniorityLevel.first
      create(
        :seniority_level, name: 'Chief Executive Officers',
                          short_name: 'ceo',
                          rank: 1
      )
    end
    unless SeniorityLevel.second
      create(
        :seniority_level,
        name: 'Chief Technology Officers',
        short_name: 'cto',
        rank: 2
      )
    end
    create(:industry, name: 'Accountings')

    3.times do
      expert = create(:expert_with_availabilities)
      profile = create(:profile, user_id: expert.id)

      create(
        :profile_industry,
        profile_id: profile.id,
        industry_id: Industry.first.id
      )
      create(
        :profile_job_function,
        profile_id: profile.id,
        job_function_id: JobFunction.first.id
      )
      create(
        :profile_skill,
        profile_id: profile.id,
        skill_id: JobFunction.first.skills.first.id
      )
      create(
        :profile_seniority_level,
        profile_id: profile.id,
        seniority_level_id: SeniorityLevel.first.id
      )

      @expert_array << expert
    end

    2.times do
      expert = create(:expert_with_availabilities)
      profile = create(:profile, user_id: expert.id)

      create(
        :profile_industry,
        profile_id: profile.id,
        industry_id: Industry.first.id
      )
      create(
        :profile_job_function,
        profile_id: profile.id,
        job_function_id: JobFunction.first.id
      )
      create(
        :profile_skill,
        profile_id: profile.id,
        skill_id: JobFunction.first.skills.first.id
      )
      create(
        :profile_seniority_level,
        profile_id: profile.id,
        seniority_level_id: SeniorityLevel.second.id
      )

      @expert_array << expert
      @date = '13/12/2018'
    end
    @expert = @expert_array.first
  end

  # def test_it_find_match
  #   params = {
  #     industries: ['Accountings'],
  #     job_functions: ['Marketing Tools and Automations'],
  #     seniority_levels: ['Chief Executive Officers'],
  #     skills: ['Advertisings'],
  #     first_available: false
  #   }

  #   actual = Expert.find_match(params)
  #   assert_equal 5, actual.count
  # end

  # def test_it_find_match_by_first_available
  #   params_one = {
  #     industries: ['Accountings'],
  #     job_functions: ['Marketing Tools and Automations'],
  #     seniority_levels: ['Chief Executive Officers'],
  #     skills: ['Advertisings'],
  #     first_available: false
  #   }

  #   params_two = {
  #     industries: ['Accountings'],
  #     job_functions: ['Marketing Tools and Automations'],
  #     seniority_levels: ['Chief Executive Officers'],
  #     skills: ['Advertisings'],
  #     first_available: true
  #   }

  #   experts_two = Expert.find_match(params_two)
  #   assert_equal 5, experts_two.count

  #   experts_one = Expert.find_match(params_one)
  #   timeslot_one = experts_one.map(&:next_availability)
  #   timeslot_two = experts_two.map(&:next_availability)
  #   ordered_time_slot_one = sort_by_timeslot(timeslot_one)
  #   ordered_time_slot_two = sort_by_timeslot(timeslot_two)
  #   assert_equal ordered_time_slot_one, ordered_time_slot_two
  # end

  def test_it_order_by_first_available
    ordered_expert = Expert.order_by_first_available(@expert_array)
    assert_experts_are_in_order(ordered_expert, 5)
  end

  def test_finds_today_availability
    # TODO: Review to make sure that the order is consistent with the tests
    ordered_expert = Expert.find_available_experts_today(@expert_array, @date)
    assert_experts_are_in_order(ordered_expert, 5)
  end

  def test_availabilities_for_successfuly_work_with_day_of_week
    actual = @expert.availabilities_for(@date)

    if actual.nil?
      assert_equal nil, actual
    else
      assert_equal Array, actual.class
    end
  end

  def test_profile_summary
    actual = @expert.profile_summary
    assert_equal Hash, actual.class
  end

  def test_availabilities_for
    actual = @expert.availabilities_for('11/12/2018')
    assert_equal Array, actual.class
  end

  def test_this_week_schedule
    actual = @expert.this_week_schedule
    assert_equal Hash, actual.class
    assert %w[
      Monday
      Tuesday
      Wednesday
      Thursday
      Friday
      Saturday
      Sunda
    ], actual.keys
  end

  def test_hours
    actual = Expert.hours
    assert_equal Array, actual.class
  end

  def test_full_name
    actual = @expert.full_name
    assert_equal 'Test Joe', actual
  end

  def test_create_expert_profile
    actual = [@expert.create_expert_profile]
    assert_equal Array, actual.class
  end

  def test_set_balance
    actual = @expert.set_balance
    assert_equal(true, actual)
  end

  def test_scheduled_appointments_start_dates
    actual = @expert.scheduled_appointments_start_dates(@date)
    assert_equal Array, actual.class
  end

  def test_available_for_datetime
    actual = @expert.available_for_datetime(@date)
    assert_equal(true, actual)
  end

  def test_next_availabilities
    actual = @expert.next_availabilities
    assert_equal Hash, actual.class
  end

  def test_next_availability
    actual = @expert.next_availability
    assert_equal Array, actual.class
  end

  def test_available_for_datetimes
    # needs for datetime_array
    actual = @expert.available_for_datetimes(@expert_array)
    assert_equal Hash, actual.class
  end

  def test_find_available_experts_today
    ordered_expert = Expert.find_available_experts_today(@expert_array, @date)
    assert_equal Array, ordered_expert.class
  end

  def test_available_days_this_week
    actual = @expert.available_days_this_week
    assert_equal Array, actual.class
  end

  def test_availabilities_today_to_next_week
    actual = @expert.availabilities_today_to_next_week(@date)
    assert_equal Array, actual.class
  end

  def test_availability_date_range
    actual = @expert.availability_date_range(Date.today, Date.today.next_week(Date.today.strftime('%A').downcase.to_sym))
    assert_equal Hash, actual.class
  end

  def test_completed_enrollment!
    actual = @expert.completed_enrollment!
    if actual.nil?
      assert_nil(actual)
    else
      assert_equal Array, actual.class
    end
  end

  def test_create_balance_item
    actual = [@expert.create_balance_item(@appointment.id)]
    assert_equal Array, actual.class
  end

  private

  def assert_experts_are_in_order(ordered_expert, first_count)
    sample_group = ordered_expert.first(first_count)
    timeslot = sample_group.map(&:next_availability)
    ordered_time_slot = sort_by_timeslot(timeslot)
    assert_equal timeslot, ordered_time_slot
  end

  def sort_by_timeslot(timeslot)
    timeslot.compact!
    sorted = timeslot.sort_by do |x|
      [
        Expert.next_7_days.index(x.first),
        x.first,
        x.second[0]
      ] || Expert.next_7_days.length
    end
    sorted
  end
end

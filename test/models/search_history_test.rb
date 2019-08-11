# frozen_string_literal: true

require 'test_helper'

describe SearchHistory do
  let(:user) { create(:user) }
  let(:industry) { create(:industry) }
  let(:service) { create(:service) }
  let(:job_function) { create(:job_function, name: "test_function_#{rand(999)}") }
  let(:skill) { create(:skill) }
  let(:seniority_level) { create(:seniority_level) }
  let(:search_history) { create(:search_history, user_id: user.id, service: service, industry: industry, functions: [job_function.id], skills: [skill.id], seniority_levels: seniority_level, description: 'You need 150 characters.') }
  let(:expert) { create(:expert) }
  let(:appointment) { create(:appointment, expert_id: expert.id, user_id: User.first.id, service_id: service.id, search_history_id: search_history.id) }

  def test_characters_complete?
    actual = search_history.characters_complete?
    assert_nil(actual)
  end

  def test_fix_service
    actual = search_history.fix_service
    assert_equal String, actual.class
  end

  def test_to_search_params
    actual = search_history.to_search_params
    assert_equal Hash, actual.class
  end

  def test_job_functions_names
    actual = job_function.name
    assert_equal appointment.search_history.job_functions_names, actual
  end

  def test_skills_names
    actual = skill.name
    assert_equal appointment.search_history.skills_names, actual
  end

  def test_industry_name
    history_search = create(:search_history, industry: industry.id)
    actual = history_search.industry_name
    assert_equal String, actual.class
  end

  def test_seniority_levels_names
    seniority_level = create(:seniority_level, name: 'test_level', short_name: 'shortName', rank: '25')
    history_search = create(:search_history, seniority_levels: [seniority_level.name])
    actual = history_search.seniority_levels_names
    assert_equal 'test_level', actual
  end

  def test_find_match
    history_search = create(:search_history)
    actual = history_search.find_match
    assert_equal Array, actual.class
  end
end

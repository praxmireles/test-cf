require 'test_helper'

class ExpertsOnboardingHelperTest < ActiveSupport::TestCase
  include ExpertsOnboardingHelper
  let(:current_user) { create(:expert) }
  let(:job_function) { create(:job_function) }
  let(:skill) { create(:skill) }

  # rubocop:disable Metrics/AbcSize
  def setup
    @language = Language.create(name: 'English', code: 'EN', native_name: 'English')
    @seniority_level = SeniorityLevel.create(name: 'Manager', short_name: 'Manager', rank: '12')
    current_user.profile.languages.create(language_id: @language.id)
    current_user.seniority_levels.new(seniority_level_id: @seniority_level.id).save
    current_user.profile.job_functions.new(job_function_id: job_function.id).save
    current_user.profile.skills.new(skill_id: skill.id).save
  end
  # rubocop:enable Metrics/AbcSize

  def test_profile_language_exists
    actual = profile_language_exists?(@language.id)
    assert_equal(true, actual)
  end

  def test_seniority_level_exists
    actual = seniority_level_exists?(@seniority_level.id)
    assert_equal(true, actual)
  end

  def test_job_function_exist
    actual = job_function_exist?(job_function.id)
    assert_equal(true, actual)
  end

  def test_skill_exist?
    actual = skill_exist?(skill.id)
    assert_equal(true, actual)
  end
end

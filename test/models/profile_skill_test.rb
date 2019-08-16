# frozen_string_literal: true

require 'test_helper'

class ProfileSkillTest < ActiveSupport::TestCase
  def setup
    expert = build_stubbed(:expert)
    profile = build_stubbed(:profile, user_id: expert.id)
    job_function = create(:job_function)
    Skill.create(job_function_id: job_function.id, name: 'Advertising')
    @profile_skill = build_stubbed(
      :profile_skill, skill_id: Skill.first.id, profile_id: profile.id
    )
  end

  def test_name
    assert_equal 'Advertising', @profile_skill.name
  end
end

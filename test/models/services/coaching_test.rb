# frozen_string_literal: true

require 'test_helper'

class CoachingTest < ActiveSupport::TestCase
  def setup
    # @job_function = JobFunction.first
    @job_function = create(:job_function)
    Skill.create(job_function_id: @job_function.id, name: 'Coaching')
    # Skill.create(job_function_id: @job_function.id, name: 'Agile Marketing')
  end

  def test_coaching_type
    # assert_equal [
    #   'One on One Coaching Executives',
    #   'Team Coaching',
    #   'Group Coaching',
    #   'Business Coaching',
    #   'Ontological Coaching',
    #   'Personal/Life Coaching',
    #   'Career Coaching',
    #   'Performance Coaching',
    #   'Newly Assigned Leader Coaching',
    #   'Succesion Coaching',
    #   'Coaching for Directors',
    #   'Coaching for Managers',
    #   'Coaching for Entrepreneurs',
    #   'Coaching for Students'
    # ]
    assert_equal ['Coaching'], @job_function.skills_name
  end
end

# frozen_string_literal: true

require 'test_helper'

class ProfileJobFunctionTest < ActiveSupport::TestCase
  def setup
    # expert = build_stubbed(:expert)
    # profile = build_stubbed(:profile, user_id: expert.id)
    @job_function = JobFunction.first
  end

  # def test_all_job_function
  #   assert_equal JobFunction.find(id), ProfileJobFunction.all_job_function
  # end
end

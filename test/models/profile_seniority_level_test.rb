# # frozen_string_literal: true
#
# require 'test_helper'
#
# class ProfileSeniorityLevelTest < ActiveSupport::TestCase
#   def setup
#     expert = build_stubbed(:expert)
#     profile = build_stubbed(:profile, user_id: expert.id)
#     @profile_seniority_level = build_stubbed(
#       :profile_seniority_level, seniority_level_id: SeniorityLevel.first.id,
#                                 profile_id: profile.id
#     )
#   end
#
#   def test_all_seniority_level
#     assert_equal 1, @profile_seniority_level.id
#   end
#
#   def test_short_name
#     assert_equal 'CEO', @profile_seniority_level.short_name
#   end
# end

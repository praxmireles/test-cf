# frozen_string_literal: true

# == Schema Information
#
# Table name: profile_seniority_levels
#
#  id                 :bigint(8)        not null, primary key
#  profile_id         :bigint(8)
#  seniority_level_id :bigint(8)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class ProfileSeniorityLevel < ApplicationRecord
  has_paper_trail

  belongs_to :profile
  belongs_to :seniority_level
  has_one :user, through: :profile
  has_one :expert, through: :profile, foreign_key: :user_id

  def all_seniority_level
    SeniorityLevel.find(seniority_level_id)
  end

  def short_name
    SeniorityLevel.find(seniority_level_id).short_name
  end
end

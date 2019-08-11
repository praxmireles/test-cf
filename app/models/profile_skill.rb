# frozen_string_literal: true

# == Schema Information
#
# Table name: profile_skills
#
#  id         :bigint(8)        not null, primary key
#  skill_id   :bigint(8)
#  profile_id :bigint(8)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ProfileSkill < ApplicationRecord
  has_paper_trail

  belongs_to :skill
  belongs_to :profile
  has_one :user, through: :profile
  has_one :expert, through: :profile, foreign_key: :user_id

  def name
    Skill.find(skill_id).name
  end

  def locale
    Skill.find(skill_id).locale
  end
end

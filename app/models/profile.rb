# frozen_string_literal: true

# == Schema Information
#
# Table name: profiles
#
#  id         :bigint(8)        not null, primary key
#  user_id    :bigint(8)
#  resume     :string
#  about      :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Profile < ApplicationRecord
  has_paper_trail

  belongs_to :user
  belongs_to :expert, foreign_key: :user_id

  has_many :job_functions,
           class_name: 'ProfileJobFunction',
           dependent: :destroy

  has_many :skills,
           class_name: 'ProfileSkill',
           dependent: :destroy

  has_many :seniority_levels,
           class_name: 'ProfileSeniorityLevel',
           dependent: :destroy

  has_many :industries,
           class_name: 'ProfileIndustry',
           dependent: :destroy

  has_many :languages,
           class_name: 'ProfileLanguage',
           dependent: :destroy

  mount_uploader :resume, ResumeUploader
end

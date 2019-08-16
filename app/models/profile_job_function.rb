# frozen_string_literal: true

# == Schema Information
#
# Table name: profile_job_functions
#
#  id              :bigint(8)        not null, primary key
#  profile_id      :bigint(8)
#  job_function_id :bigint(8)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class ProfileJobFunction < ApplicationRecord
  has_paper_trail

  belongs_to :profile
  belongs_to :job_function
  has_one :user, through: :profile
  has_one :expert, through: :profile, foreign_key: :user_id

  def all_job_function
    JobFunction.find(job_function_id) if job_function_id
  end

  def self.skills
    JobFunction.find(ids).skills_name
  end

  def name
    JobFunction.find(job_function_id).name
  end

  def locale
    JobFunction.find(job_function_id).locale
  end
end

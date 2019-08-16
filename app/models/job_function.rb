# frozen_string_literal: true

# == Schema Information
#
# Table name: job_functions
#
#  id         :bigint(8)        not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class JobFunction < ApplicationRecord
  has_paper_trail

  validates_uniqueness_of :name
  has_many :skills

  def skills_name
    skills.order(created_at: :asc).pluck(:name)
  end
end

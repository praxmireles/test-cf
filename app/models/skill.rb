# frozen_string_literal: true

# == Schema Information
#
# Table name: skills
#
#  id              :bigint(8)        not null, primary key
#  job_function_id :bigint(8)
#  name            :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Skill < ApplicationRecord
  has_paper_trail

  belongs_to :job_function

  def function
    job_function.name
  end
end

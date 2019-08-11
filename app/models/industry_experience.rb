# frozen_string_literal: true

# == Schema Information
#
# Table name: industry_experiences
#
#  id                 :bigint(8)        not null, primary key
#  user_id            :bigint(8)
#  name               :string
#  experience_in_year :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class IndustryExperience < ApplicationRecord
  has_paper_trail

  belongs_to :user
end

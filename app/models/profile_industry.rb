# frozen_string_literal: true

# == Schema Information
#
# Table name: profile_industries
#
#  id          :bigint(8)        not null, primary key
#  profile_id  :bigint(8)
#  industry_id :bigint(8)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class ProfileIndustry < ApplicationRecord
  has_paper_trail

  belongs_to :profile
  belongs_to :industry
  has_one :user, through: :profile
  has_one :expert, through: :profile, foreign_key: :user_id
end

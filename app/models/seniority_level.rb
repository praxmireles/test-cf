# frozen_string_literal: true

# == Schema Information
#
# Table name: seniority_levels
#
#  id         :bigint(8)        not null, primary key
#  name       :string
#  short_name :string
#  rank       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class SeniorityLevel < ApplicationRecord
  has_paper_trail

  validates_uniqueness_of :name
  validates_uniqueness_of :rank
  validates_uniqueness_of :short_name

  def self.name_asc
    order(name: :asc)
  end
end

# frozen_string_literal: true

# == Schema Information
#
# Table name: work_histories
#
#  id              :bigint(8)        not null, primary key
#  user_id         :bigint(8)
#  title           :string
#  company         :string
#  location        :string
#  from_date       :datetime
#  to_date         :datetime
#  present         :boolean
#  linkedin_import :boolean          default(FALSE)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class WorkHistory < ApplicationRecord
  has_paper_trail
  belongs_to :user

  validates :from_date, presence: true, timeliness: { type: :date }
  validate :to_date_after_from_date?, on: :create
  validates :title, :company, :location, :from_date, presence: true

  SIZE = ['Small 1 to 100 Employees', 'Medium 101 to 1000 Employees',
          'Large 1001 to 5000 Employees',
          'Global 5001 and presence in a at least 2 continents'].freeze

  def self.sizes
    SIZE
  end

  def to_date_after_from_date?
    return true unless to_date.present? && from_date.present?
    if to_date.present? && to_date < from_date
      errors.add(:to_date, 'Must be after start date')
    elsif to_date > Date.current
      errors.add(:to_date, 'Must be before date today')
    end
  end
end

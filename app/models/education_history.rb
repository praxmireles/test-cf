# frozen_string_literal: true

# == Schema Information
#
# Table name: education_histories
#
#  id              :bigint(8)        not null, primary key
#  user_id         :bigint(8)
#  degree          :string
#  field_of_study  :string
#  from_date       :datetime
#  to_date         :datetime
#  present         :boolean
#  linkedin_import :boolean          default(FALSE)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class EducationHistory < ApplicationRecord
  has_paper_trail

  belongs_to :user

  validates :from_date, :to_date, timeliness: { on_or_before: -> { Date },
                                                allow_blank: true }
  validates :degree, :field_of_study, :from_date, presence: true
  validate :to_date_after_from_date?

  DEGREE = ['GED', 'High School', 'Associates', 'Bachelors', 'Postgradute',
            'Masters', 'Doctorate', 'Diploma', 'Nor Specified'].freeze

  def self.degrees
    DEGREE
  end

  private

  def to_date_after_from_date?
    return true unless to_date.present? && from_date.present?
    if to_date.present? && to_date < from_date
      errors.add(:to_date, 'Must be after start date')
    elsif to_date > Date.current
      errors.add(:to_date, 'Must be before date today')
    end
  end
end

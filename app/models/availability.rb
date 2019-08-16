# frozen_string_literal: true

# == Schema Information
#
# Table name: availabilities
#
#  id          :bigint(8)        not null, primary key
#  user_id     :bigint(8)
#  day_of_week :string
#  start_time  :time
#  end_time    :time
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Availability < ApplicationRecord
  has_paper_trail

  belongs_to :user
  validates_uniqueness_of :start_time, scope: %i[user_id day_of_week]

  after_create :assign_end_time

  # Array of users available on a given day, or day and time
  #
  # Returns [Array]
  def self.experts_available_on?(day_of_week, time = nil)
    if time.nil?
      Availability.where('day_of_week = ?', day_of_week).pluck(:user_id)
    else
      Availability.where(
        'day_of_week = ? & start_time = ?', day_of_week, time
      ).pluck(:user_id)
    end
  end

  # The hours of :start_time
  #
  # Returns [String]
  def start_hours
    start_time.strftime('%H')
  end

  # The minutes of :start_time
  #
  # Returns [String]
  def start_minutes
    start_time.strftime('%M')
  end

  # The hours of end_time
  #
  # Returns [String]
  def end_hours
    end_time.strftime('%H')
  end

  # The hours of end_time
  #
  # Returns [String]
  def end_minutes
    end_time.strftime('%M')
  end

  # Start_time to AM and PM
  #
  # Returns [String]
  #
  # usage:
  # Availability.first.start_time
  # => "16:00"
  # Availability.first.start_time_to_meridian
  # => "04:00 PM"
  def start_time_to_meridian
    start_time.strftime('%P')
  end

  def assign_end_time
    self.end_time = start_time + 30.minutes
    save
  end
end

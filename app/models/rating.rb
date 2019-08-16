# frozen_string_literal: true

# == Schema Information
#
# Table name: ratings
#
#  id             :bigint(8)        not null, primary key
#  user_id        :bigint(8)
#  expert_id      :integer
#  appointment_id :bigint(8)
#  rate           :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Rating < ApplicationRecord
  has_paper_trail

  belongs_to :user
  belongs_to :appointment

  # This method only works with a class inheriting from Rating
  def current
    if ratings
      ratings.sum / ratings.size
    else
      logger.warn '[BAD_USAGE] This method should only be used by a children class'
    end
  end

  def ratings
    logger.warn '[BAD_USAGE] This method should only be used by a children class'
  end
end

# frozen_string_literal: true

# == Schema Information
#
# Table name: services
#
#  id              :bigint(8)        not null, primary key
#  type            :string
#  duration_in_min :integer
#  price           :float
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Service < ApplicationRecord
  has_paper_trail

  SERVICES_TYPES = %w[Coaching ExpressAdvice Mentoring ProjectInMind].freeze

  has_many :appointment_packs

  def name
    type.underscore.humanize
  end
end

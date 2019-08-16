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

class Coaching < Service
  has_one :introduction, foreign_key: :service_id

  # returns a list of coaching types
  #
  # Returns Array
  def self.coaching_types
    JobFunction.find_by(name: 'Coaching').skills_name
  end
end

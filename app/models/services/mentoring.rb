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

class Mentoring < Service
  has_one :introduction, foreign_key: :service_id
end

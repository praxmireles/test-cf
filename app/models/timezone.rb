# frozen_string_literal: true

# == Schema Information
#
# Table name: timezones
#
#  id             :bigint(8)        not null, primary key
#  name           :string
#  utc_difference :integer
#  continent      :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Timezone < ApplicationRecord
  has_paper_trail

  validates_uniqueness_of :name

  def self.name_asc
    order(name: :asc)
  end
end

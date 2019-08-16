# frozen_string_literal: true

# == Schema Information
#
# Table name: introductions
#
#  id              :bigint(8)        not null, primary key
#  service_id      :bigint(8)
#  name            :string
#  duration_in_min :integer
#  price           :float
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Introduction < ApplicationRecord
  has_paper_trail

  belongs_to :service, foreign_key: :service_id
end

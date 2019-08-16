# frozen_string_literal: true

# == Schema Information
#
# Table name: career_highlights
#
#  id          :bigint(8)        not null, primary key
#  user_id     :bigint(8)
#  name        :string
#  description :string
#  date        :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class CareerHighlight < ApplicationRecord
  has_paper_trail

  belongs_to :user

  validates :date, timeliness: { on_or_before: -> { Date }, allow_blank: true }
  validates :name, :description, :date, presence: true
end

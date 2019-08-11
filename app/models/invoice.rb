# frozen_string_literal: true

# == Schema Information
#
# Table name: invoices
#
#  id             :bigint(8)        not null, primary key
#  user_id        :bigint(8)
#  expert_id      :integer
#  payment_id     :bigint(8)
#  appointment_id :integer
#  date           :datetime
#  due_date       :datetime
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Invoice < ApplicationRecord
  has_paper_trail

  belongs_to :user
  belongs_to :payment
  belongs_to :appointment

  def mark_as_paid
    update_attributes(paid_on: Time.now)
  end
end

# frozen_string_literal: true

# == Schema Information
#
# Table name: appointments
#
#  id                  :bigint(8)        not null, primary key
#  user_id             :bigint(8)
#  type                :string           default("OpenAppointment")
#  expert_id           :integer
#  service_id          :integer
#  first_available     :integer
#  video_session_uid   :string
#  video_session_token :string
#  cancel_reason       :string
#  description         :string
#  stripe_charge_uid   :string
#  subject             :string
#  cancelled_on        :datetime
#  cancelled           :boolean
#  duration_in_min     :integer
#  time_spent_in_min   :integer
#  offline             :boolean
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  start_date          :datetime
#  end_date            :datetime
#  cancelled_by        :string
#  search_history_id   :bigint(8)
#  request_id          :bigint(8)
#  price               :float
#  completed_on        :datetime
#  scheduled_on        :datetime
#  appointment_pack_id :integer
#  introduction        :boolean          default(FALSE)
#  day_of_week         :string
#  close_on            :datetime
#  close               :boolean
#

class CompletedAppointment < Appointment
  after_save :update_time_spent_in_min
  after_save :update_balance

  def update_time_spent_in_min
    return unless time_spent_in_min.blank? && completed_on.present?
    spent_in_min = (end_date - completed_on) / 60
    self.time_spent_in_min = spent_in_min.round
    save
  end

  # rubocop:disable Metrics/AbcSize
  def update_balance
    expert = Expert.find(expert_id)
    if !BalanceItem.where(user_id: expert_id, appointment_id: id).empty?
      puts "[WARNING] A BALANCE ITEM for appointment_id #{appointment_id} with user_id: #{expert_id} already exists."
    else
      expert.balance.balance_items.create!(
        user_id: expert_id,
        appointment_id: id,
        amount: amount_due_to_expert,
        description: " #{service.try(:type)} | #{client.try(:fullname)}"
      )
    end
    expert.balance.calculate_total_amount!
  end

  private 

  def amount_due_to_expert
    Configuration.first.present? ? (price * (1 - Configuration.first.service_fees)) : 0
  end


  # rubocop:enable Metrics/AbcSize
end

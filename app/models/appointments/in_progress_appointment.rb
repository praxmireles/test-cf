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

class InProgressAppointment < Appointment
  validates_uniqueness_of :start_date, scope: :expert_id
  validates_uniqueness_of :start_date, scope: :user_id

  def complete!
    update_attributes(
      type: 'CompletedAppointment',
      completed_on: Time.now
    )

    appointment_pack_is_complete? if appointment_packs.any?

    notify_user(:appointment,
                action: :appointment_completed,
                appointment_id: id)
  end

  # Check if the appointment_pack that an appointment belongs to is complete
  def appointment_pack_is_complete?
    complete_appointment_pack! if appointment_pack.complete?
  end

  # Determine that a client has completed its appointment pack
  def complete_appointment_pack!
    appointment_pack.update_attributes(type: 'CompletedAppointmentPack')
  end
end

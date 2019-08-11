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
#  introduction        :boolean          default(FALSE)
#  day_of_week         :string
#  close_on            :datetime
#  close               :boolean
#

# An appointment where its request is pending for approval
class OpenAppointment < Appointment
  def schedule_appointment!
    expert = Expert.find(expert_id)
    return false unless expert.available_for_datetime(start_date)

    update_attributes(
      type: 'ScheduledAppointment',
      scheduled_on: Time.now
    )

    update_appointment_pack if appointment_packs.any?

    notify_user(:appointment,
                action: :appointment_is_scheduled,
                appointment_id: id)
  end

  def update_appointment_pack
    appointment_pack.update_attributes(
      type: 'ScheduledAppointment'
    )
  end
end

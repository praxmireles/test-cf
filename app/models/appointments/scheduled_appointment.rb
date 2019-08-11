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

class ScheduledAppointment < Appointment
  include Opentokable

  validates_uniqueness_of :start_date, scope: :expert_id
  validates_uniqueness_of :start_date, scope: :user_id
  
  def start!
    opentok_session = create_session(user_id, id)
    self.type = 'InProgressAppointment'
    self.video_session_token = opentok_session[:token]
    self.video_session_uid = opentok_session[:session_id]
    save
  end

  def cancel_by_client!
    cancel!('Client')
  end

  def cancel_by_expert!
    cancel!('Expert')
  end

  def cancel!(client_or_expert)
    update_attributes(
      type: 'CancelledAppointment',
      cancelled_on: Time.now,
      cancelled: true,
      cancelled_by: client_or_expert
    )

    notify_user(:appointment,
                action: :appointment_is_cancelled,
                appointment_id: id)
  end
end

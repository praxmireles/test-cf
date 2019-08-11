# frozen_string_literal: true

# == Schema Information
#
# Table name: requests
#
#  id                :bigint(8)        not null, primary key
#  user_id           :bigint(8)
#  type              :string           default("PendingRequest")
#  rescheduled       :boolean
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  expert_id         :integer
#  search_history_id :bigint(8)
#

# Pending requests are requests were payment were already pre-authorized
class PendingRequest < Request
  def accept!(skip: false)
    self.type = 'AcceptedRequest'
    save

    appointment.charge_for_session(appointment.id) unless skip
    schedule_appointment
  end

  def reject!
    self.type = 'RejectedRequest'
    save

    close_appointment
  end

  def cancel!
    self.type = 'CancelledRequest'
    save

    close_appointment
  end

  # Start an appointment
  #
  # Params:
  # - Appointment [Hash]
  # -- expert_id [Integer]
  # -- client_id [Integer]
  # -- service_id [Integer]
  # -- day_of_week [String]
  # -- start_date [DateTime]
  # -- search_history_id [Integer]
  #
  # Return
  def initialize_appointment!(appointment)
    expert = Expert.find(appointment[:expert_id])
    service = Service.find(appointment[:service_id])

    description = 'Lorem Ipsum is simply dummy text of the printing and \
      typesetting industry.'
    if service.respond_to? :introduction
      introduction = true
      subject = 'Introduction'
    else
      subject = 'Session'
    end

    pending_appointment = OpenAppointment.new(
      request_id: id,
      user_id: appointment[:client_id],
      expert_id: expert.id,
      service_id: appointment[:service_id],
      day_of_week: appointment[:day_of_week],
      start_date: appointment[:start_date],
      search_history_id: appointment[:search_history_id],
      subject: subject,
      description: description,
      introduction: introduction
    )

    if pending_appointment.save
      pending_appointment
    else
      puts "---- 🔸 FAILURE | while saving pending_appointment \
      error:#{pending_appointment.errors.messages} 🔸 \
      in initialize_appointment"
      false
    end
  end

  private

  def schedule_appointment
    return false unless appointment
    appointment.type = 'ScheduledAppointment'
    save
  end

  def close_appointment
    return false unless appointment
    appointment.update_attributes(type: 'ClosedAppointment')
    true
  end
end

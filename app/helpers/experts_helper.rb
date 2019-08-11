# frozen_string_literal: true

module ExpertsHelper
  def appointment_class(appointment_type)
    if appointment_type == 'InProgressAppointment'
      'inProgress'
    elsif appointment_type == 'ScheduledAppointment'
      'scheduled'
    elsif appointment_type == 'OpenAppointment'
      'pending'
    else
      'past'
    end
  end

  def appointment_types_ordered_array
    %w[
      InProgressAppointment
      ScheduledAppointment
      CompletedAppointment
      CancelledAppointment
      ClosedAppointment
    ]
  end
end

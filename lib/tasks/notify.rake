# rubocop:disable Metrics/BlockLength
namespace :notify do
  desc 'Generate expert notification and mailer'
  task expert_enrollment: :environment do
    expert = Expert.last
    category = :expert_enrollment
    actions = %i[
      expert_unfinished_enrollment
      expert_finished_enrollment
      admin_approve_expert
      admin_reject_expert
    ]
    actions.each do |action|
      expert.notify_user(category,
                         action: action,
                         user_id: expert.id)
    end
  end

  desc 'Generate client notification and mailer'
  task client_enrollment: :environment do
    client = Client.last
    category = :client_enrollment
    actions = %i[
      client_unfinished_enrollment
      client_finished_enrollment
      client_didnt_hire_expert
    ]

    actions.each do |action|
      client.notify_user(category,
                         action: action,
                         user_id: client.id)
    end
  end

  desc 'Generate appointment notification and mailer'
  task appointment: :environment do
    appointment = Appointment.last
    category = :appointment
    actions = %i[
      new_appointment_request
      approved_appointment
      appointment_is_rejected
      appointment_is_cancelled
      appointment_is_scheduled
      appointment_will_start
      appointment_started
      appointment_completed
      received_client_feedback
      unanswered_request
    ]

    actions.each do |action|
      appointment.notify_user(category,
                              action: action,
                              appointment_id: appointment.id)
    end
  end

  desc 'Generate payment notification and mailer'
  task payment: :environment do
    payment = Payment.last
    category = :payment
    actions = %i[
      paid_appointment
      sent_payout
      send_receipt
    ]

    actions.each do |action|
      payment.notify_user(category,
                          action: action,
                          payment_id: payment.id)
    end
  end
end
# rubocop:enable Metrics/BlockLength

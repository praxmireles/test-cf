# rubocop:disable Metrics/BlockLength
namespace :mailers do
  task all: :environment do
    Rake::Task['mailers:appointment'].invoke
    Rake::Task['mailers:client'].invoke
    Rake::Task['mailers:expert'].invoke
    Rake::Task['mailers:payment'].invoke
  end

  desc 'Trigger all the mailer for AppointmentMailer and deliver them in devleopment'
  task payment: :environment do
    user = User.first
    client = Client.first
    expert = Expert.first
    payment = Payment.first

    if Rails.env.development?
      return 0 unless user && client && expert && payment
      PaymentMailer.paid_appointment(user.id, payment.id).deliver
      PaymentMailer.sent_payout(expert.id, payment.id).deliver
      PaymentMailer.send_receipt(client.id, payment.id).deliver
      return 1
    end
  end

  desc 'Trigger all the mailer for AppointmentMailer and deliver them in devleopment'
  task client: :environment do
    user = User.first
    client = Client.first
    appointment = Appointment.first

    if Rails.env.development?
      return 0 unless user && client && appointment
      ClientMailer.find_an_expert(client.id).deliver
      ClientMailer.welcome(client.id).deliver
      ClientMailer.service_reminder(client.id).deliver
      return 1
    end
  end

  desc 'Trigger all the mailer for AppointmentMailer and deliver them in devleopment'
  task expert: :environment do
    user = User.first
    expert = Expert.first
    appointment = Appointment.first

    return 0 unless user && expert && appointment

    if Rails.env.development?
      ExpertMailer.unfinished_enrollment(expert.id).deliver
      ExpertMailer.finished_enrollment(expert.id).deliver
      ExpertMailer.account_approved(expert.id).deliver
      ExpertMailer.account_rejected(expert.id).deliver
      ExpertMailer.appointment_notice(expert.id).deliver
    end
  end

  desc 'Trigger all the mailer for AppointmentMailer and deliver them in devleopment'
  task appointment: :environment do
    user = User.first
    client = Client.first
    expert = Expert.first
    appointment = Appointment.first

    if Rails.env.development?
      return 0 unless user && client && expert && appointment

      AppointmentMailer.new_appointment_request(
        user.id, appointment.id
      ).deliver

      AppointmentMailer.approved_appointment(
        user.id, appointment.id
      ).deliver

      AppointmentMailer.appointment_is_rejected(
        user.id, appointment.id
      ).deliver

      AppointmentMailer.appointment_is_cancelled(
        user.id, appointment
        .id
      ).deliver

      AppointmentMailer.appointment_is_scheduled(
        user.id, appointment.id
      ).deliver

      AppointmentMailer.appointment_will_start(
        user.id, appointment.id
      ).deliver

      AppointmentMailer.appointment_started(
        user.id, appointment.id
      ).deliver

      AppointmentMailer.appointment_completed(
        user.id, appointment.id
      ).deliver

      AppointmentMailer.received_client_feedback(
        user.id, appointment.id
      ).deliver

      AppointmentMailer.unanswered_request(
        user.id, appointment.id
      ).deliver

      AppointmentMailer.client_feedback_reminder(
        client.id, appointment.id
      ).deliver

      AppointmentMailer.expert_feedback_reminder(
        expert.id, appointment.id
      ).deliver

      # AppointmentMailer.first_available_request(
      #   expert.id, appointment.id
      # ).deliver

      AppointmentMailer.previous_expert_first_available_notice(
        expert.id, appointment.id
      ).deliver

      AppointmentMailer.express_advice_request(
        expert.id, appointment.id
      ).deliver

      return 1
    end
  end
end
# rubocop:enable Metrics/BlockLength

# Mailer for Appointment logic
class AppointmentMailer < ApplicationMailer
  default from: 'team@mindswithpurpose.com'
  layout 'mailer'

  def new_appointment_request(user_id, appointment_id)
    @user = User.find(user_id)
    @appointment = Appointment.find(appointment_id)
    mail(
      to: @user.email,
      subject: 'Mindswithpurpose - New Appointment Request'
    )
  end

  def approved_appointment(user_id, appointment_id)
    @user = User.find(user_id)
    @appointment = Appointment.find(appointment_id)
    mail(
      to: @user.email,
      subject: 'Mindswithpurpose - Approved Appointment'
    )
  end

  def appointment_is_rejected(user_id, appointment_id)
    @user = User.find(user_id)
    @appointment = Appointment.find(appointment_id)
    mail(
      to: @user.email,
      subject: 'Mindswithpurpose - Appointment Was Rejected'
    )
  end

  def appointment_is_cancelled(user_id, appointment_id)
    @user = User.find(user_id)
    @appointment = Appointment.find(appointment_id)
    mail(
      to: @user.email,
      subject: 'Mindswithpurpose - Appointment Was Cancelled'
    )
  end

  def appointment_is_scheduled(user_id, appointment_id)
    @user = User.find(user_id)
    @appointment = Appointment.find(appointment_id)
    mail(
      to: @user.email,
      subject: 'Mindswithpurpose - Appointment Is Scheduled'
    )
  end

  def appointment_will_start(user_id, appointment_id)
    @user = User.find(user_id)
    @appointment = Appointment.find(appointment_id)
    mail(
      to: @user.email,
      subject: 'Mindswithpurpose - Appointment Will Start in 15min'
    )
  end

  def appointment_started(user_id, appointment_id)
    @user = User.find(user_id)
    @appointment = Appointment.find(appointment_id)
    mail(
      to: @user.email,
      subject: 'Mindswithpurpose - Appointment Started'
    )
  end

  def appointment_completed(user_id, appointment_id)
    @user = User.find(user_id)
    @appointment = Appointment.find(appointment_id)
    mail(
      to: @user.email,
      subject: 'Mindswithpurpose - Appointment Completed'
    )
  end

  def received_client_feedback(user_id, appointment_id)
    @user = User.find(user_id)
    @appointment = Appointment.find(appointment_id)
    mail(
      to: @user.email,
      subject: 'Mindswithpurpose - Received Client Feedback'
    )
  end

  def unanswered_request(user_id, appointment_id)
    @user = User.find(user_id)
    @appointment = Appointment.find(appointment_id)
    mail(
      to: @user.email,
      subject: 'Mindswithpurpose - Unanswered Request'
    )
  end

  def client_feedback_reminder(client_id, appointment_id)
    @client = User.find(client_id)
    @appointment = Appointment.find(appointment_id)
    mail(
      to: @client.email,
      subject: "Mindswithpurpose - Review Your Previous Session \
      with #{@appointment.expert.fullname}"
    )
  end

  def expert_feedback_reminder(expert_id, appointment_id)
    @expert = User.find(expert_id)
    @appointment = Appointment.find(appointment_id)
    mail(
      to: @expert.email,
      subject: "Mindswithpurpose - Review Your Previous Session \
      with #{@appointment.client.fullname}"
    )
  end

  # Express Advice with First Available Expert
  # (Message to the First Available)
  def first_available_request(expert_id, appointment_id)
    @expert = User.find(expert_id)
    @appointment = Appointment.find(appointment_id)
    mail(
      to: @expert.email,
      subject: 'Mindswithpurpose - First Available Expert Request'
    )
  end

  # Express Advice with First Available Expert (Message to Client that
  # session has been accepted)
  def client_first_available_expert_request(client_id, appointment_id)
    @client = User.find(client_id)
    @appointment = Appointment.find(appointment_id)
    mail(
      to: @client.email,
      subject: 'Mindswithpurpose - Client First Available Expert Request'
    )
  end

  # Express Advice with First Available Expert (Message to Experts who were
  # invited when session has been accepted by other Expert)
  def previous_expert_first_available_notice(expert_id, appointment_id)
    @expert = User.find(expert_id)
    @appointment = Appointment.find(appointment_id)
    mail(
      to: @expert.email,
      subject: 'Mindswithpurpose - Another Expert accepted this session'
    )
  end

  # Express Advice with selected Expert (Message to the Selected Expert)
  def express_advice_request(expert_id, appointment_id)
    @expert = User.find(expert_id)
    @appointment = Appointment.find(appointment_id)
    mail(
      to: @expert.email,
      subject: 'Mindswithpurpose - Express Advice Request'
    )
  end
end

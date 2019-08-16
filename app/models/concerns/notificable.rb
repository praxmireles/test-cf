# frozen_string_literal: true

# Related files
# - initializers/notification_mailer.rb : To initialize the config that matches an action with a mailer
# - config/notification_mailers.yml : The config that match a notification with a mailer
# - config/initializers/en.yml : To setup the message
module Notificable
  extend ActiveSupport::Concern

  included do
    # Notification Handler
    #
    # To submit a notification you'll need to use a category followed by an options containing
    # an action and the object id.
    #
    # example:
    # - :category (required option)
    # --- :action
    #
    # Available Categories and Actions:
    #
    # - :expert_enrollment (user_id)
    # --- :expert_unfinished_enrollment
    # --- :expert_finished_enrollment
    # --- :admin_approve_expert
    # --- :admin_reject_expert
    # - :client_enrollment (user_id)
    # --- :client_unfinished_enrollment
    # --- :client_finished_enrollment
    # --- :client_didnt_hire_expert
    # - :appointment (appointment_id)
    # --- :new_appointment_request
    # --- :approved_appointment
    # --- :appointment_is_rejected
    # --- :appointment_is_cancelled
    # --- :appointment_is_scheduled
    # --- :appointment_will_start
    # --- :appointment_started
    # --- :appointment_completed
    # --- :received_client_feedback
    # --- :unanswered_request
    # - :payment (payment_id)
    # --- :paid_appointment
    # --- :sent_payout
    #
    # Each category expects a combination of action and options:
    # exampe of options are:
    # - action, user_id,  appointment_id, payment_id
    #
    # View notify_user method bellow for details
    #
    # e.g:
    # notify_user(:expert_enrollment, {
    #  action: :expert_finished_enrollment,
    #  user_id: user.id
    # })
    #
    def notify_user(category, options)
      case category
      # require an action and user_id
      when :expert_enrollment
        send_expert_enrollment_notification(
          options[:action], options[:user_id]
        )
      # requires an action and user_id
      when :client_enrollment
        send_client_enrollment_notification(
          options[:action], options[:user_id]
        )
      # requires an aciton and appointment_id
      when :appointment
        send_appointment_notification(
          options[:action], options[:appointment_id]
        )
      # require an action and payment_id
      when :payment
        send_payment_notification(options[:action], options[:payment_id])
      else
        warn "[NOTIFICATION_ERROR] Category '#{category}' doesn\'t exists"
      end
    end
  end

  private

  def send_client_enrollment_notification(action, user_id)
    client = User.find(user_id)
    case action
    when :client_unfinished_enrollment
      send_notification(client.id, nil, action)
    when :client_finished_enrollment
      send_notification(client.id, nil, action)
    when :client_didnt_hire_expert
      send_notification(client.id, nil, action)
    else
      warn "[NOTIFICATION_ERROR] Action '#{action}' doesn\'t exists"
    end
  end

  def send_expert_enrollment_notification(action, user_id)
    expert = User.find(user_id)
    case action
    when :expert_unfinished_enrollment
      send_notification(expert.id, nil, action)
      notify_admin(expert.id, action)
    when :expert_finished_enrollment
      send_notification(expert.id, nil, action)
      notify_admin(expert.id, action)
    when :admin_approve_expert
      send_notification(expert.id, nil, action)
    when :admin_reject_expert
      send_notification(expert.id, nil, action)
    else
      warn "[NOTIFICATION_ERROR] Action '#{action}' doesn\'t exists"
    end
  end

  def send_appointment_notification(action, appointment_id)
    appointment = Appointment.find(appointment_id)
    client = appointment.client
    expert = appointment.expert
    return unless appointment

    case action
    when :new_appointment_request
      send_notification(client.id, appointment_id, action)
      send_notification(expert.id, appointment_id, action)
    when :approved_appointment
      send_notification(client.id, appointment_id, action,
                        wildcard: expert.fullname.to_s)
      send_notification(expert.id, appointment_id, action,
                        wildcard: client.fullname.to_s)
    when :appointment_is_rejected
      send_notification(client.id, appointment_id, action,
                        prefix: expert.fullname.to_s)
      send_notification(expert.id, appointment_id, action,
                        prefix: client.fullname.to_s)
    when :appointment_is_cancelled
      send_notification(client.id, appointment_id, action,
                        suffix: expert.fullname.to_s)
      send_notification(expert.id, appointment_id, action,
                        suffix: client.fullname.to_s)
    when :appointment_is_scheduled
      send_notification(client.id, appointment_id, action,
                        suffix: appointment.start_date)
      send_notification(expert.id, appointment_id, action,
                        suffix: appointment.start_date)
    when :appointment_will_start
      send_notification(
        client.id,
        appointment_id,
        action,
        prefix: "#{client.fullname} "
      )
      send_notification(expert.id, appointment_id, action)
    when :appointment_started
      send_notification(client.id, appointment_id, action)
      send_notification(expert.id, appointment_id, action)
    when :appointment_completed
      send_notification(client.id, appointment_id, action,
                        wildcard: expert.fullname.to_s)
      send_notification(expert.id, appointment_id, action,
                        wildcard: client.fullname.to_s)
    when :received_client_feedback
      send_notification(client.id, appointment_id, action)
      send_notification(expert.id, appointment_id, action)
    when :unanswered_request
      send_notification(client.id, appointment_id, action)
      send_notification(expert.id, appointment_id, action)
    else
      warn "[NOTIFICATION_ERROR] Action '#{action}' doesn\'t exists"
    end
  end

  def send_payment_notification(action, payment_id)
    payment = Payment.find(payment_id)
    client_id = payment.user_id
    expert_id = payment.appointment.expert_id
    return unless payment
    case action
    when :paid_appointment
      send_notification(client_id, payment_id, action)
    when :sent_payout
      send_notification(expert_id, payment_id, action)
    when :send_receipt
      send_notification(client_id, payment_id, action)
    when :pre_authorized_appointment
      send_notification(client_id, payment_id, action)
    else
      warn "[NOTIFICATION_ERROR] Action '#{action}' doesn\'t exists"
    end
  end

  # Create Notification and Send Email
  # variable [Hash] that takes a suffix or prefix
  # e.g: {prefix: "#{user.name}", suffix: "#{user.location}"}
  def send_notification(user_id, optional_id, action, variables = {})
    ActiveRecord::Base.transaction do
      user = User.find(user_id)
      I18n.locale = user.locale
      user.notifications.create!(
        action: action,
        locale: "notifications.#{action}",
        wildcard: variables[:wildcard],
        prefix: variables[:prefix],
        suffix: variables[:suffix]
      )
      mailer = NOTIFICATION_MAILER[action.to_sym.to_s]['mailer'].constantize
      mailer_method = NOTIFICATION_MAILER[action.to_sym.to_s]['method']
      if optional_id
        # TODO: update to work with .deliver_later
        mailer.send(mailer_method.to_sym, user_id, optional_id).deliver
      else
        # TODO: Verify that mailer worker is working with .deliver_later method
        mailer.send(mailer_method.to_sym, user_id).deliver # .deliver_later
      end
    end
  rescue ActiveRecord::RecordInvalid => exception
    STDERR.puts "[FAILED_NOTIFICATION] Something went wrong while submitting the notification for #{action}"
    Rollbar.log('error', exception.message, user_id: user_id, optional_id: optional_id, action: action, variables: variables)
  end

  def notify_admin(expert_id, action)
    admin = AdminUser.second
    expert = Expert.find(expert_id)
    return unless admin.present?
    admin.notifications.create!(
      mesage: "#{expert.first_name} #{expert.last_name} <#{expert.email}>" +
              I18n.t("admin_notifications.#{action}"),
      action: action
    )
  end
end

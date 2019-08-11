# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                      :bigint(8)        not null, primary key
#  type                    :string
#  first_name              :string
#  last_name               :string
#  username                :string
#  active                  :boolean          default(FALSE)
#  email                   :string
#  job                     :string
#  company                 :string
#  facebook_url            :string
#  google_url              :string
#  linkedin_url            :string
#  avatar                  :string
#  provider                :string
#  stripe_customer_id      :string
#  hourly_rate             :float
#  accepted_privacy_policy :boolean          default(FALSE)
#  accepted_policy_on      :datetime
#  facebook_uid            :string
#  linkedin_uid            :string
#  completed_onboarding    :boolean          default(FALSE)
#  location                :string
#  timezone_id             :integer
#  coach                   :boolean          default(FALSE)
#  last_sign_in_ip         :string
#  current_sign_in_ip      :string
#  last_sign_in_at         :datetime
#  sign_in_count           :integer
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  current_card_id         :integer
#

class Client < User
  has_paper_trail

  has_many :cards, foreign_key: :user_id, dependent: :destroy
  has_many :payments, foreign_key: :user_id, dependent: :destroy
  has_many :invoices, foreign_key: :user_id, dependent: :destroy
  has_many :search_histories, foreign_key: :user_id, dependent: :destroy

  has_many :open_appointments, foreign_key: :user_id, dependent: :destroy
  has_many :scheduled_appointments, foreign_key: :user_id, dependent: :destroy
  has_many :in_progress_appointments, foreign_key: :user_id, dependent: :destroy
  has_many :cancelled_appointments, foreign_key: :user_id, dependent: :destroy
  has_many :completed_appointments, foreign_key: :user_id, dependent: :destroy
  has_many :closed_appointments, foreign_key: :expert_id, dependent: :destroy

  has_many :open_requests, foreign_key: :user_id, dependent: :destroy
  has_many :accepted_requests, foreign_key: :user_id, dependent: :destroy
  has_many :rejected_requests, foreign_key: :user_id, dependent: :destroy
  has_many :pending_requests, foreign_key: :user_id, dependent: :destroy
  has_many :cancelled_requests, foreign_key: :user_id, dependent: :destroy
  has_many :failed_payments, foreign_key: :client_id, dependent: :destroy

  # has_one :contact_information, class_name: 'ContactInformation',
  #                                 foreign_key: :user_id, dependent: :delete_all
  # has_many :billing, class_name: 'Billing',
  # foreign_key: :user_id, dependent: :destroy
  has_many :work_histories, foreign_key: :user_id, dependent: :destroy

  def current_card
    cards.find(current_card_id)
  end

  def completed_enrollment!
    self.completed_onboarding = true
    save

    notify_user(:client_enrollment,
                action: :client_finished_enrollment,
                user_id: id)
  end

  # Return an array of bookings from User's Scheduled Appointment
  #
  # Return [Array] of [DateTime]
  def scheduled_appointments_start_dates(strftime)
    scheduled_appointments.map do |a|
      a.start_date.strftime(strftime)
    end
  end

  def update_payment(appointment_id, appointment_pack_id = nil)
    appointment = Appointment.find(appointment_id)
    payments.create(
      user_id: id,
      appointment_id: appointment_id,
      appointment_pack_id: appointment_pack_id,
      amount: appointment.service.price,
      card_last4: appointment.client,
      charge_id: appointment.stripe_charge_uid,
      brand: '',
      exp_month: '',
      exp_year: ''
    )
    # appointment.update_attributes(payment_id: payment.id)
  end

  def create_invoices(appointment_id)
    appointment = Appointment.find(appointment_id)
    invoices.create!(
      user_id: appointment.client.id,
      expert_id: appointment.expert.id,
      payment_id: appointment.payment.id,
      appointment_id: appointment.id,
      date: Time.now,
      due_date: Time.now,
      amount: (appointment.service.price / 100)
    )
  end

  def create_appointment_pack_invoices(appointment_pack_id)
    appointment_pack = AppointmentPack.find(appointment_pack_id)
    invoices.create!(
      user_id: appointment_pack.client.id,
      expert_id: appointment_pack.expert.id,
      payment_id: appointment_pack.payment.id,
      appointment_pack_id: appointment_pack.id,
      date: Time.now,
      due_date: Time.now,
      amount: (appointment_pack.service.price / 100)
    )
  end
end

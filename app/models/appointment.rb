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

require_dependency 'timeable'
class Appointment < ApplicationRecord
  has_paper_trail

  include Timeable
  include Notificable
  include Marketplaceable

  belongs_to :client, foreign_key: :user_id
  belongs_to :service
  belongs_to :expert

  belongs_to :request, optional: true
  belongs_to :search_history, optional: true

  has_one :invoice, dependent: :delete
  has_one :payment, dependent: :delete
  has_one :rating, dependent: :delete
  has_one :balance_item, dependent: :delete
  has_one :application_balance_item, dependent: :delete

  has_many :shared_documents, dependent: :delete_all
  has_many :expired_authorizations, dependent: :delete_all

  has_many :failed_payments, foreign_key: :appointment_id, dependent: :delete_all

  before_save :assign_end_date_from_service
  before_save :assign_price_from_service
  before_save :assign_duration_from_service
  before_save :assing_day_of_the_week
  after_save  :prepare_scheduled_appointment


  has_and_belongs_to_many :appointment_packs

  has_paper_trail

  TYPES = %w[
    InProgressAppointment
    ScheduledAppointment
    CompletedAppointment
    ClosedAppointment
    CancelledAppointment
  ].freeze

  scope :order_by_type, lambda {
    ordered = []
    TYPES.each do |type|
      each do |x|
        ordered << x if x.type == type
      end
    end
    ordered
  }

  def was_completed?
    completed_on.present?
  end

  def assign_duration_from_service
    self.duration_in_min = service.try(:duration_in_min) if service.present?
  end

  def assign_end_date_from_service
    self.end_date = start_date + service.duration_in_min.minute if service.present?
  end

  def assign_price_from_service
    self.price = if (
      service.respond_to? :introduction
    ) && (introduction == true)
                   service.try(:introduction).try(:price)
                 else
                   service.try(:price)
                 end
  end

  def assing_day_of_the_week
    self.day_of_week = start_date.strftime('%A')
  end

  def appointment_pack
    appointment_packs.first
  end

  def appointment_suggests(user_type)
    @suggest = []
    AppointmentSuggest.where(appointment_id: id).each do |s|
      @suggest.push(s) if s.user.type == user_type
    end
    @suggest
  end

  def charge_for_session(appointment_id)
    appointment = Appointment.find(appointment_id)
    charge = settle_pre_authorized_transaction(appointment.stripe_charge_id)
    payment = Payment.find_by_charge_id(appointment.stripe_charge_id)
    payment.update_attributes(paid: true) if charge
  end

  def prepare_scheduled_appointment
    return unless type == 'ScheduledAppointment'
    AppointmentInProgressWorker.perform_at(
        self.start_date,
        self.id
    )
    UpcomingAppointmentWorker.perform_at(
        self.start_date - 15.minute,
        self.id
    )
  end

  # schedule scheduled_appointmnet to be changed to in_progress_appointment
  def self.prepare_today_scheduled_appointment
    schedule_appointments = ScheduledAppointment.all

    schedule_appointments.each do |appointment|
      AppointmentInProgressWorker.perform_at(
        appointment.start_date,
        appointment.id
      )

      UpcomingAppointmentWorker.perform_at(
        appointment.start_date - 15.minute,
        appointment.id
      ) if appointment.start_date < 16.minutes.from_now
    end
  end

  def self.cancel_late_pending_request
    # TODO: Fix this logic
    # auto_cancelation_days = Configuration.first.confirmation_max_days
    # pending_requests = PendingRequest.all
    # pending_requests.each do |pending_request|
    #   pending_request.cancel! if pending_request.created_at > auto_cancelation_days.days.ago
    # end
  end

  def due_to_expert
    price * (1 - fees)
  end

  def due_to_application
    price * fees
  end

  def fees
    Configuration.try(:first).try(:service_fees) || 0.2
  end

  def activate_request(stripe_charge_id)
    update_attributes(stripe_charge_id: stripe_charge_id)
    expert.create_balance_item(id)
    client.create_invoices(id)
    request.try(:activate!)
  end
end

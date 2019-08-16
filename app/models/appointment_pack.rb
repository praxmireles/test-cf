# frozen_string_literal: true

# == Schema Information
#
# Table name: appointment_packs
#
#  id          :bigint(8)        not null, primary key
#  user_id     :bigint(8)
#  type        :string           default("OpenAppointmentPack")
#  expert_id   :integer
#  price       :float
#  description :text
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  service_id  :bigint(8)
#

class AppointmentPack < ApplicationRecord
  has_paper_trail

  belongs_to :user
  belongs_to :client, foreign_key: :user_id
  belongs_to :expert
  belongs_to :service
  # has_many :bookings
  # has_many :appointments, through: :bookings
  has_one :payment, dependent: :delete
  has_and_belongs_to_many :appointments

  # This only removes records from the join table
  before_destroy do
    appointments.each(&:destroy)
  end

  # Params:
  # - appointment_pack [Hash]:
  # -- client_id [Integer]
  # -- expert_id [Integer]
  # -- description [String]
  # -- name [String]
  # -- start_dates [Array]
  def self.schedule_appointments(appointment_pack_params)
    OpenAppointmentPack.transaction do
      appointment_pack = OpenAppointmentPack.new(
        user_id: appointment_pack_params[:user_id],
        expert_id: appointment_pack_params[:expert_id],
        description: appointment_pack_params[:description],
        name: appointment_pack_params[:name],
        service_id: appointment_pack_params[:service_id]
      )

      if appointment_pack.save
        if populate_with_appointments(
          appointment_pack,
          appointment_pack_params[:start_dates]
        )
          appointment_pack.type = 'OpenAppointmentPack'
          appointment_pack.save
          appointment_pack
        else
          false
        end
      else
        puts "ERROR: #{appointment_pack.errors}"
        false
      end
    end
  end
  # TO DO: We can improve the way we handle error and false

  # Params
  # - appointment_array [Array]: List of start_date
  # rubocop:disable Metrics/AbcSize
  def populate_with_appointments(
    appointments_start_dates
  )
    appointments_start_dates.each do |start_date|
      expert = Expert.find(expert_id)
      if expert.available_for_datetime(start_date)
        appointment = appointments.new(
          user_id: user_id,
          service_id: service_id,
          expert_id: expert_id,
          description: description,
          start_date: start_date,
          duration_in_min: service.duration_in_min,
          type: 'OpenAppointment'
        )

        if appointment.save
          appointments << appointment
          true
        else
          puts "---- 🔸 FAILURE | while saving appointment \
          error:#{appointment.errors.messages}🔸\
          in populate_with_appointments"
          false
        end
      else
        puts "---- 🔸 FAILURE | Expert(#{expert.id}) not available for \
        start_date #{start_date}🔸in populate_with_appointments"
        return false
      end
    end
  end
  # rubocop:enable Metrics/AbcSize

  def calculate_price
    total_price = appointments.count * service.price
    self.price = total_price
  end

  def price_per_session
    service.price
  end

  # take intersectin of two arays and see if it's empty
  # if its empty then the appointment pack is completed.
  def complete?
    statuses = appointments.pluck(:type)
    statuses.uniq!
    statuses_to_check = %w[
      InProgessAppointment
      OpenAppointment
      ScheduledAppointment
    ]

    if (statuses_to_check & statuses).any?
      false
    else
      true
    end
  end

  def cancel!
    self.type = 'CancelledAppointmentPack'
    cancel_all_scheduled_appointments
  end

  def past_appointments
    appointments.where(
      'type = ? OR type = ? OR type = ?',
      'CancelledAppointment',
      'CompletedAppointment',
      'ClosedAppointment'
    )
  end

  def completed_appointments_count
    appointments.where(
      'type = ?',
      'CompletedAppointment'
    ).count
  end

  # def activate_request(stripe_charge_id)
  #   update_attributes(stripe_charge_id: stripe_charge_id)
  #   expert.create_balance_item(id)
  #   client.create_invoices(id)
  # end

  private

  def cancel_all_scheduled_appointments
    appointments.map { |x| x.cancel! if x.type == 'ScheduledAppointment' }
  end
end

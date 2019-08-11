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

class User < ApplicationRecord
  has_one :billing, dependent: :destroy
  has_one :contact_information, dependent: :delete

  has_many :appointment_packs, dependent: :delete_all

  has_many :notifications, dependent: :destroy
  has_many :ratings, dependent: :destroy
  has_many :availabilities, dependent: :destroy
  has_many :access_tokens, dependent: :destroy
  has_many :appointments, dependent: :destroy
  has_many :requests, dependent: :destroy

  has_many :coachings, through: :appointments, source: :service, dependent: :destroy
  has_many :express_advices, through: :appointments, source: :service, dependent: :destroy
  has_many :mentorings, through: :appointments, source: :service, dependent: :destroy
  has_many :project_in_minds, through: :appointments, source: :service, dependent: :destroy

  accepts_nested_attributes_for :contact_information

  has_and_belongs_to_many :applicant, foreign_key: :user_id
  before_destroy do
    PendingApplicant.find_by(user_id: id).try(:destroy)
  end

  # validates_uniqueness_of :email, allow_blank: true

  mount_uploader :avatar, AvatarUploader
  mount_uploader :files, DocumentUploader

  serialize :current_onboarding_step, Hash

  has_paper_trail

  include Notificable

  def fullname
    "#{first_name} #{last_name}."
  end

  def timezone
    # timezone_id = default_time_zone if timezone_id.nil?
    Timezone.find(timezone_id) if timezone_id
  end

  # TODO: verificacion de los metodos

  # def timezone_utc_difference
  #   timezone_id = default_time_zone if timezone_id.nil?
  #   time_zone = Timezone.find(timezone_id) if timezone_id
  #   @timezone_utc_difference = time_zone.utc_difference
  # end
  #
  # def timezone_continent
  #   timezone_id = default_time_zone if timezone_id.nil?
  #   time_zone = Timezone.find(timezone_id) if timezone_id
  #   time_zone.continent
  # end
  #
  # def timezone_name
  #   timezone_id = default_time_zone if timezone_id.nil?
  #   time_zone = Timezone.find(timezone_id) if timezone_id
  #   time_zone.name
  # end

  def unread_notifications
    notifications.where(type: 'NewNotification')
  end

  # TODO: Update user's timezone based on the location during
  # Facebook sign up
  def update_timezone_from_location; end

  # private

  # def default_time_zone
  #   6
  # end
end

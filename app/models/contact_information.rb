# frozen_string_literal: true

# == Schema Information
#
# Table name: contact_informations
#
#  id               :bigint(8)        not null, primary key
#  user_id          :bigint(8)
#  primary_phone    :string
#  secondary_phone  :string
#  primary_mobile   :string
#  secondary_mobile :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class ContactInformation < ApplicationRecord
  has_paper_trail

  belongs_to :user

  serialize :mobile_contact_time
  serialize :phone_contact_time
end

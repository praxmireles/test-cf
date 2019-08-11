# frozen_string_literal: true

# == Schema Information
#
# Table name: billings
#
#  id         :bigint(8)        not null, primary key
#  user_id    :bigint(8)
#  street     :string
#  city       :string
#  state      :string
#  zip        :string
#  country    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Billing < ApplicationRecord
  has_paper_trail

  belongs_to :user
end

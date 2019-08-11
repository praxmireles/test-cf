# frozen_string_literal: true

# == Schema Information
#
# Table name: cards
#
#  id                    :bigint(8)        not null, primary key
#  user_id               :bigint(8)
#  stripe_card_uid       :string
#  stripe_card_brand     :string
#  stripe_card_last4     :string
#  stripe_card_exp_month :string
#  stripe_card_exp_year  :string
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#

class Card < ApplicationRecord
  has_paper_trail

  belongs_to :user
end

# frozen_string_literal: true

# == Schema Information
#
# Table name: access_tokens
#
#  id         :bigint(8)        not null, primary key
#  user_id    :bigint(8)
#  provider   :string
#  token      :string
#  expires_at :datetime
#  expired    :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class AccessToken < ApplicationRecord
  has_paper_trail
  belongs_to :user
end

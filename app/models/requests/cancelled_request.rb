# frozen_string_literal: true

# == Schema Information
#
# Table name: requests
#
#  id                :bigint(8)        not null, primary key
#  user_id           :bigint(8)
#  type              :string           default("PendingRequest")
#  rescheduled       :boolean
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  expert_id         :integer
#  search_history_id :bigint(8)
#

class CancelledRequest < Request
end

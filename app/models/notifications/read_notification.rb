# frozen_string_literal: true

# == Schema Information
#
# Table name: notifications
#
#  id         :bigint(8)        not null, primary key
#  type       :string           default("NewNotification")
#  user_id    :bigint(8)
#  message    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ReadNotification < Notification
  def mark_unread
    update_attributes(type: 'NewNotification') unless type == 'NewNotification'
  end
end

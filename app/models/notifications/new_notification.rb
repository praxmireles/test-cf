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

class NewNotification < Notification
  def mark_read
    update_attributes(type: 'ReadNotification') unless type == 'ReadNotification'
  end
end

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

class Notification < ApplicationRecord
  has_paper_trail

  belongs_to :user

  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/CyclomaticComplexity
  # rubocop:disable Metrics/PerceivedComplexity
  def translate_message
    return message unless locale.present?
    if wildcard.present?
      I18n.t(locale).gsub('[wildcard]', wildcard)
    elsif prefix.nil? && suffix.present?
      "#{I18n.t(locale)} #{suffix}"
    elsif prefix.present? && suffix.present?
      "#{prefix} #{I18n.t(locale)}
        #{suffix}"
    else
      I18n.t(locale)
    end
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/CyclomaticComplexity
  # rubocop:enable Metrics/PerceivedComplexity
end

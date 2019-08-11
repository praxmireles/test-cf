# frozen_string_literal: true

module ApplicationHelper
  def format_date_long(date)
    I18n.l date, format: :long
  ensure
    I18n.t('not_available')
  end

  def set_in_timezone(time, user_id)
    user = User.find(user_id)
    if user.timezone.present?
      time.in_time_zone(user.timezone.zone_name)
    else
      time.in_time_zone(Time.zone)
    end
  end
end

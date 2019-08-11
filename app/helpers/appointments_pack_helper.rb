module AppointmentsPackHelper
  def append_date_class(index, length)
    if index.zero?
      'beginning_of_current_week'
    elsif (index + 1) == length
      'end_of_current_week'
    end
  end

  def session_unscheduled_count(package_option, dates_selected)
    package_option.to_i - dates_selected.length
  end
end

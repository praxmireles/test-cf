# frozen_string_literal: true

module ClientsHelper
  def date_to_time(datetime)
    datetime.strftime('%l:%M %p')
  end

  def matching_skills(search_history_id, skills)
    search_history = SearchHistory.find(search_history_id)
    matching_skills = skills.select do |skill|
      (search_history.skills_names.include? skill.name) if search_history.skills
    end
    matching_skills
  end

  def appointment_from_search_history(search_history_id)
    Appointment.find_by(search_history: search_history_id)
  end
end

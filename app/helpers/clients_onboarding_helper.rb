module ClientsOnboardingHelper
  def show_service_name(service)
    if service == 'Mentoring'
      'Mentoring With Purpose'
    elsif service == 'Coaching'
      'Coaching with Purpose'
    elsif service == 'ExpressAdvice'
      'Express Advice'
    else
      service
    end
  end
end

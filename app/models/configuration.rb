class Configuration < ApplicationRecord
  def pull_latest
    update_attributes(
      express_advice_price: services_config['express_advice']['price'],
      mentoring_price: services_config['mentoring']['price'],
      coaching_price: services_config['coaching']['price'],
      mentoring_introduction_price: services_config['mentoring']\
        ['introduction']['price'],
      coaching_introduction_price: services_config['coaching']['introduction']\
          ['price'],
      auto_cancelation_in_days: 2,
      confirmation_max_days: 2,
      service_fees: configuration_config['payments']['service_fees']
    )
  end

  def update_service_duration
    express_advice = Service.find_by_type('ExpressAdvice')
    mentoring = Service.find_by_type('Mentoring')
    coaching = Service.find_by_type('Coaching')

    express_advice.update_attributes(
      duration_in_min: services_config['express_advice']['duration_in_min']
    )

    mentoring.update_attributes(
      duration_in_min: services_config['mentoring']['duration_in_min']
    )

    coaching.update_attributes(
      duration_in_min: services_config['coaching']['duration_in_min']
    )

    mentoring.introduction.update_attributes(
      duration_in_min: services_config['mentoring']['introduction']\
      ['duration_in_min']
    )

    coaching.introduction.update_attributes(
      duration_in_min: services_config['coaching']['introduction']\
      ['duration_in_min']
    )
  end

  private

  def services_config
    services_config_path = Rails.root.join('config', 'services.yml')
    YAML.load_file(services_config_path)
  end

  def configuration_config
    configuration_config_path = Rails.root.join('config', 'configuration.yml')
    YAML.load_file(configuration_config_path)
  end
end

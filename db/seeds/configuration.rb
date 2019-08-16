puts 'SETTING CONFIGURATION...'

services_config_path = Rails.root.join('config', 'services.yml')
services_config = YAML.load_file(services_config_path)

configuration_config_path = Rails.root.join('config', 'configuration.yml')
configuration_config = YAML.load_file(configuration_config_path)

configuration = Configuration.new(
  express_advice_price: services_config['express_advice']['price'],
  mentoring_price: services_config['mentoring']['price'],
  coaching_price: services_config['coaching']['price'],
  mentoring_introduction_price: services_config['mentoring']['introduction']\
    ['duration_in_min'],
  coaching_introduction_price: services_config['coaching']['introduction']\
    ['duration_in_min'],
  auto_cancelation_in_days: 2,
  confirmation_max_days: 2,
  service_fees: configuration_config['payments']['service_fees']
)

if configuration.save
  puts 'Created Configuration [ ✅ ]'
else
  puts 'Failed creating Configuration [ 🔴 ]'
end

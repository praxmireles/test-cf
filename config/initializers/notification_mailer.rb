notification_mailer_config_path = Rails.root.join(
  'config',
  'notification_mailers.yml'
)
NOTIFICATION_MAILER = YAML.load_file(notification_mailer_config_path)

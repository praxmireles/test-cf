require 'paypal-sdk-rest'

PayPal::SDK.configure(
  mode: ENV['PAYPAL_MODE'], # "sandbox" or "live"
  client_id: ENV['PAYPAL_CLIENT_ID'],
  client_secret: ENV['PAYPAL_CLIENT_SECRET'],
  ssl_options: ENV['SSL_OPTIONS'] || {}
)

PayPal::SDK.logger = Logger.new(STDERR)

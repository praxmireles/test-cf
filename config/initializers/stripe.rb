require 'stripe'
Stripe.api_key = Rails.env.test? ? 'sk_test_0xDwBEX4pS83Wc49dftL5lZx' : ENV['STRIPE_SECRET_KEY']

# Stripe Controller to receive the webhook
class StripeController < ApplicationController
  protect_from_forgery except: :webhook
  include StripeWebhookable

  def webhook
    event_json = JSON.parse(request.body.read)

    case event_json['type']
    when 'charge.expired'
      handle_expired_preauthorization(event_json)
    end
  end
end

# Stripe Webhook
module StripeWebhookable
  extend ActiveSupport::Concern
  included do
    # Event: charge.expired
    def handle_expired_preauthorization(event_json)
      charge = event_json['data']['object']
      payment = Payment.find_by(charge_id: charge['id'])
      return unless payment
      ExpiredAuthorization.create!(
        payment_id: payment.id,
        appointment_id: payment.appointment_id
      )
    end
  end
end

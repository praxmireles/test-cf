require_relative 'stripe_response'

# StripStub
module StripeStub
  include StripeResponse

  def stub_retrieve_customer
    Stripe::Customer.stubs(:retrieve).returns(stripe_customer_retrieve)
  end

  def stub_retrieve_customer_returns_nil
    Stripe::Customer.stubs(:retrieve).returns(nil)
  end

  def stub_create_customer
    Stripe::Customer.stubs(:create).returns(stripe_customer_create)
  end

  def stub_create_charge
    Stripe::Charge.stubs(:create).returns(stripe_charge_create)
  end
end

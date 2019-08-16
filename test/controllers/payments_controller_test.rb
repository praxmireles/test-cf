# # frozen_string_literal: true

# require 'test_helper'

# class PaymentsControllerTest < ActionController::TestCase
#   # include MarketplaceableTest

#   before { StripeMock.start }
#   after { StripeMock.stop }
#   def setup
#     @controller = PaymentsController.new
#     @stripe_helper = StripeMock.create_test_helper
#     @client = create(:client)
#     customer = Stripe::Customer.create(email: 'johnny@appleseed.com', source: @stripe_helper.generate_card_token)
#     c_t = create(:client, stripe_customer_id: customer.id)
#     expert = create(:expert)
#     s = create(:service)
#     @his = create(:search_history, user_id: c_t.id)
#     create(:appointment, expert_id: expert.id, user_id: c_t.id, service_id: s.id, search_history_id: @his.id)
#   end

#   def test_create
#     @controller.stub(:current_user, @client) do
#       post :create, params: { stripeToken: @stripe_helper.generate_card_token, search_history_id: @his.id }
#       assert_response 302
#     end
#   end
# end

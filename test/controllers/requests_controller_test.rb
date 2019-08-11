# frozen_string_literal: true

require 'test_helper'
require 'omniauth_stub'
require 'stripe_stub'
require 'stripe_response'

class RequestsControllerTest < ActionController::TestCase
  include StripeResponse
  include StripeStub

  def setup
    @controller = RequestsController.new
    @expert = create(:expert_with_availabilities)
    @client = create(:client)
    @service = create(:service)
    @search_history = create(:search_history, client: @client)
    @controller.stubs(:current_user).returns(@client)
  end

  def test_create
    post :create, params: {
      appointment: {
        search_history_id: @search_history.id,
        expert_id: @expert.id,
        client_id: @client.id,
        service_id: @service.id,
        start_date: Time.parse("Monday 12:30 PM").to_datetime,
      }
    }
    assert_redirected_to root_path
  end

  def test_create_fails
    PendingRequest.any_instance.stubs(:save).returns(false)

    post :create, params: {
      appointment: {
        expert_id: @expert.id,
        search_history_id: @search_history.id
      }
    }
    assert_response 500
  end

  def test_create_saving_initialize_appointment_fails
    OpenAppointment.any_instance.stubs(:save).returns(false)

    post :create, params: {
      appointment: {
        search_history_id: @search_history.id,
        expert_id: @expert.id,
        client_id: @client.id,
        service_id: @service.id,
        start_date: Time.parse("Monday 12:30 PM").to_datetime,
      }
    }
    assert_response 500
  end

  def test_edit
    request = create(
      :request,
      search_history_id: @search_history.id,
      client: @client,
      expert: @expert
    )
    get :edit, params: {
      request_id: request.id
    }
    assert_response 200
  end

  def test_edit_fail_to_find_a_request
    get :edit, params: {
      request_id: 99_999
    }
    assert_response 404
  end

  # rubocop:disable Metrics/AbcSize
  def test_update_when_accepted
    request = create(
      :request,
      search_history_id: @search_history.id,
      client: @client,
      expert: @expert
    )
    create(
      :open_appointment,
      request_id: request.id,
      client: @client,
      expert: @expert,
      search_history_id: @search_history.id,
      service: Service.first
    )

    card = create(:card, user_id: @client.id)
    @client.current_card_id = card.id
    @client.save

    # stub_create_charge
    PendingRequest.any_instance.stubs(:accept!).returns(true)

    PaymentMailer.any_instance.stubs(:deliver).returns(true)

    put :update, params: {
      request_id: request.id,
      answer: 'accept'
    }
    assert_redirected_to root_path
  end
  # rubocop:enable Metrics/AbcSize

  def test_update_when_rejected
    request = create(
      :request,
      search_history_id: @search_history.id,
      client: @client,
      expert: @expert
    )
    create(
      :open_appointment,
      request_id: request.id,
      client: @client,
      expert: @expert,
      search_history_id: @search_history.id,
      service: Service.first
    )

    put :update, params: {
      request_id: request.id,
      answer: 'reject'
    }
    assert_redirected_to root_path
  end

  def test_destroy
    request = create(
      :request,
      search_history_id: @search_history.id,
      client: @client,
      expert: @expert
    )
    create(
      :open_appointment,
      request_id: request.id,
      client: @client,
      expert: @expert,
      search_history_id: @search_history.id,
      service: Service.first
    )
    delete :destroy, params: { request_id: request.id }
    assert_redirected_to root_path
  end
end

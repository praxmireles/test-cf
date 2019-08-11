# frozen_string_literal: true

require 'test_helper'

class AppointmentTest < ActiveSupport::TestCase
  def setup
    @expert = create(:expert)
    @client = create(:client)
    @search_history = create(:search_history, client: @client)
    @service = create(:service)
    @request = create(
      :request,
      search_history_id: @search_history.id,
      client: @client,
      expert: @expert
    )
  end

  def test_assign_price_from_service
    intro_session = create(:scheduled_intro_appointment,
                           expert: @expert,
                           client: @client,
                           search_history: @search_history,
                           request: @request,
                           service:  @service)
    assert_equal 57.0, intro_session.price
  end
end

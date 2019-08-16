# frozen_string_literal: true

require 'test_helper'

class VideoConferencesControllerTest < ActionController::TestCase
  def setup
    @controller = VideoConferencesController.new
    @client = create(:client_with_apppointments)
    @appointment = @client.in_progress_appointments.first
    Opentok.stubs(:create_session).returns(
      OpenStruct.new(
        session_id: '123_MX404NjF-WVVWFM5NWRSflB-',
        generate_token: 'T1==123_m5vbmNlPMyNg=='
      )
    )
  end

  def test_show_is_succcessful
    @controller.stub(:current_user, @client) do
      get :show, params: { appointment_id: @appointment.id }
      assert_equal 'InProgressAppointment', Appointment.find(
        @appointment.id
      ).type
      assert_response 200
    end
  end

  # def test_show_fails
  #   @controller.stub(:current_user, @client) do
  #     post :show, params: { appointment_id: 5000 }
  #     assert_response 302
  #   end
  # end
end

# frozen_string_literal: true

require 'test_helper'

# describe NotificationsController do
#   # it "must be a real test" do
#   #   flunk "Need real tests"
#   # end
# end

class NotificationsControllerTest < ActionController::TestCase
  def setup
    @client = User.first
    @notice = Notification.create(user: @client, message: "asda")
    @controller = NotificationsController.new
  end

  def test_read_one
    @controller.stub(:current_user, @client) do
      get :read_one, params: { notification_id: @notice.id, format: 'js' }, xhr: true
      assert_response 200
    end
  end
end

# frozen_string_literal: true

require 'test_helper'
require 'omniauth_stub'

class SessionsControllerTest < ActionController::TestCase
  def setup
    @controller = SessionsController.new
  end

  def test_new
    get :new
    assert_response 200
  end

  def test_destroy
    delete :destroy
    assert_nil @controller.session[:user_id]
  end
end

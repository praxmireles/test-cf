# frozen_string_literal: true

require 'test_helper'
require 'omniauth_stub'

class AuthenticationsControllerTest < ActionController::TestCase
  def setup
    @controller = AuthenticationsController.new
  end

  def test_it_fails_to_create_a_new_user_without_facebook_uid
    request.env["omniauth.auth"] = {}
    post :create, params: { provider: 'facebook' }
    assert_response 500
  end

  def test_it_successfully_create_facebook_user
    request.env["omniauth.auth"] = OmniauthStub.facebook_response
    post :create, params: { provider: 'facebook' }
    assert_redirected_to root_path
  end

  def test_it_successfully_create_linkedin_user
    request.env["omniauth.auth"] = OmniauthStub.linkedin_response
    post :create, params: { provider: 'linkedin', user_type: 'Expert' }
    assert_redirected_to root_path
  end

  def test_fields_from_facebook
    facebook = @controller.send(
      :fields_from_facebook,
      OmniauthStub.facebook_response
    )
    assert_equal facebook,
                 email: 'joe@bloggs.com',
                 first_name: 'Joe',
                 last_name: 'Bloggs',
                 remote_avatar_url: 'http://graph.facebook.com/1234567/picture?type=square',
                 facebook_url: "http://www.facebook.com/jbloggs"
  end

  def test_fields_from_linkedin
    linkedin = @controller.send(
      :fields_from_linkedin,
      OmniauthStub.linkedin_response,
      'Expert'
    )
    assert_equal linkedin,
                 email: "john@doe.com",
                 first_name: "John",
                 last_name: "Doe",
                 remote_avatar_url: nil
    # linkedin_url: "http://www.linkedin.com/in/johndoe"
  end
end

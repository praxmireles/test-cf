# frozen_string_literal: true

# Manages pages and actiono related to user login
class AuthenticationsController < ApplicationController
  def new; end

  # rubocop disable:Metrics/AbcSize:
  def create
    user = fetch_user_from_params(request)

    if user
      session[:user_id] = user.id
      redirect_to root_url
    else
      render 'sessions/new', status: 500
    end
  rescue StandardError => e
    logger.error e.message
    logger.error e.backtrace.join("\n")
  end
  # rubocop enable:Metrics/AbcSize:

  def stripe_callback
    options = {
      site: 'https://connect.stripe.com',
      authorize_url: '/oauth/authorize',
      token_url: '/oauth/token'
    }

    code = params[:code]
    stripe_client = OAuth2::Client.new(
      ENV['STRIPE_CONNECT_CLIENT_ID'],
      ENV['STRIPE_SECRET_KEY'],
      options
    )

    response = stripe_client.auth_code.get_token(
      code,
      params: { scope: 'read_write' }
    )

    if response
      # user_stripe_token = response.token
      current_user.update_attributes(
        stripe_account_id: response.params['stripe_user_id']
      )
      redirect_to balance_expert_path
    else
      redirect_back(fallback: root_path)
    end
  end

  private

  def fetch_user_from_params(request)
    auth = request.env['omniauth.auth']
    user_type = params[:user_type] ||
                request.env.dig('omniauth.params', 'user_type')
    case params[:provider]
    when 'facebook'
      login_with_facebook(auth)
    when 'linkedin'
      login_with_linkedin(auth, user_type)
    end
  end

  def login_with_facebook(auth)
    return unless auth[:uid].present?
    user = User.find_or_create_by(
      provider: 'facebook',
      facebook_uid: auth['uid'],
      type: 'Client'
    )

    if user.save
      user.update_attributes(fields_from_facebook(auth))
      user.access_tokens.find_or_create_by(token_fields_for_facebook(auth))
    end

    user
  end

  def login_with_linkedin(auth, user_type)
    return unless user_type.present?
    return unless auth['uid'].present?
    user_type_list = %w[Expert Client]
    return unless user_type_list.include?(user_type)
    user = User.find_or_create_by(
      provider: 'linkedin',
      linkedin_uid: auth['uid'],
      type: user_type
    )

    if user.save
      user.update_attributes(fields_from_linkedin(auth, user_type))
      user.access_tokens.find_or_create_by(token_fields_for_linkedin(auth))
    end

    user
  end

  # Returns the fields that we want from facebook. Update this methods
  # to add additional fields from Facebook
  def fields_from_facebook(auth)
    return unless auth[:info]
    {
      email: auth[:info][:email],
      first_name: auth[:info][:first_name],
      last_name: auth[:info][:last_name],
      remote_avatar_url: auth[:info][:image],
      facebook_url: auth[:extra][:raw_info][:link]
    }
  end

  # Returns fields that we want from linkeind. Update this methods
  # to add additional fields from Facebook
  def fields_from_linkedin(auth, _user_type)
    return unless auth['info']
    {
      email: auth['info']['email'],
      first_name: auth['info']['first_name'],
      last_name: auth['info']['last_name'],
      remote_avatar_url: auth['info']['picture_url']
    }
    # TODO: Activate the r_basicprofile permission on the linkedin panel
  end

  def token_fields_for_facebook(auth)
    expires_at = Time.at(auth[:credentials][:expires_at]).to_datetime
    access_token_fields(
      'linkedin',
      auth[:credentials][:token],
      expires_at
    )
  end

  def token_fields_for_linkedin(auth)
    return unless auth['credentials']
    expires_in = auth['credentials']['expires_at']
    expires_at = Time.at(expires_in.to_i).to_datetime

    access_token_fields(
      'linkedin',
      auth['credentials']['token'],
      expires_at
    )
  end

  def access_token_fields(provider, token, expires_at)
    {
      provider: provider,
      token: token,
      expires_at: expires_at
    }
  end
end

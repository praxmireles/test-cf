# Manage the locale for multiple languages support
class LocalesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def update
    if current_user
      return unless valid_locale_param!
      current_user.update_attributes(locale: params[:id])
      I18n.locale = current_user.locale
    else
      cookies[:locale] = params[:id].to_sym
      I18n.locale = cookies[:locale]
    end
    redirect_back(fallback_location: root_path)
  end

  private

  def valid_locale_param!
    return true if I18n.available_locales.include? params[:id].to_sym
    false
  end
end

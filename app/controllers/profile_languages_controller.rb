# User's Languages
class ProfileLanguagesController < ApplicationController
  def create
    redirect_to degrees_path if destroy_all_and_create(params[:languages])
  end

  def destroy
    current_user.profile.languages.find(
      params[:language_id]
    ).destroy
  end

  private

  def add_languages(languages)
    new_languages = []
    languages.each do |language_id|
      new_language = current_user.profile.languages.create!(
        language_id: language_id
      )

      new_languages << new_language if new_language.created_at?
    end
    if new_languages.empty?
      false
    else
      true
    end
  end

  def destroy_all_and_create(languages)
    current_user.profile.languages.destroy_all
    add_languages(languages)
  end
end

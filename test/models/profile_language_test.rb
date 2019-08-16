# frozen_string_literal: true

require 'test_helper'

class ProfileLanguageTest < ActiveSupport::TestCase
  def setup
    # expert = build_stubbed(:expert)
    # profile = build_stubbed(:profile, user_id: expert.id)
    @profile_language = Language.create(name: 'English', code: 'EN', native_name: 'English')
  end

  # def test_all_language
  #   assert_equal Language.find(id), ProfileLanguage.all_language
  # end

  def test_code
    assert_equal 'EN', @profile_language.code
  end
end

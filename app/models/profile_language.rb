# frozen_string_literal: true

# == Schema Information
#
# Table name: profile_languages
#
#  id          :bigint(8)        not null, primary key
#  profile_id  :bigint(8)
#  language_id :bigint(8)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class ProfileLanguage < ApplicationRecord
  has_paper_trail

  belongs_to :profile
  belongs_to :language

  has_one :expert, through: :profile, foreign_key: :user_id
  validates :profile_id, presence: true

  def all_language
    Language.find(language_id)
  end

  def code
    Language.find(language_id).code
  end

  def name
    Language.find(language_id).name
  end
end

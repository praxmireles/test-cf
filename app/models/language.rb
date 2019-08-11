# frozen_string_literal: true

# == Schema Information
#
# Table name: languages
#
#  id          :bigint(8)        not null, primary key
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  code        :string
#  native_name :string
#

class Language < ApplicationRecord
  has_paper_trail

  validates_uniqueness_of :name
end

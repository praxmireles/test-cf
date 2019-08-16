class Applicant < ApplicationRecord
  has_paper_trail
  has_and_belongs_to_many :users
  belongs_to :user
  has_paper_trail
  # def user
  #   User.find(user_id)
  # end
end

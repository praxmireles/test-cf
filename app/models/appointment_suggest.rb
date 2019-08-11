class AppointmentSuggest < ApplicationRecord
  has_paper_trail
  belongs_to :appointment
  belongs_to :user
end

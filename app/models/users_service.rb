# frozen_string_literal: true

class UsersService < ApplicationRecord
  has_paper_trail

  belongs_to :user
  belongs_to :service

  def self.all_service
    services = []
    services.each do |_id|
      services << Service.find(service_id)
    end
    services
  end

  def name
    service = Service.find(service_id)
    service.type
  end
end

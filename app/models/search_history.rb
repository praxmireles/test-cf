# frozen_string_literal: true

# == Schema Information
#
# Table name: search_histories
#
#  id              :bigint(8)        not null, primary key
#  user_id         :bigint(8)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  first_available :boolean
#  service         :string
#  functions       :string
#  skills          :string
#  seniority_level :string
#  coaching_type   :string
#
require 'job_function'
require 'skill'
require 'seniority_level'
require_dependency 'notificable'

class SearchHistory < ApplicationRecord
  include Notificable
  has_paper_trail

  belongs_to :client, foreign_key: :user_id
  has_many :appointments
  has_one :request, dependent: :destroy

  serialize :functions
  serialize :skills
  serialize :industry
  serialize :seniority_levels

  before_save :fix_service

  def characters_complete?
    errors.add(:description, 'You need 150 characters.') if description.scan(/\w+/).size >= 31
  end

  def fix_service
    self.service = service.delete(' ') if service
  end

  def to_search_params
    {
      service: service,
      industry: industry,
      job_functions: functions,
      skills: skills,
      seniority_levels: seniority_levels
    }
  end

  def job_functions_names
    JobFunction.find(functions).pluck(:name).join(', ') if functions
  end

  def skills_names
    Skill.find(skills).pluck(:name).join(', ') if skills
  end

  def industry_name
    Industry.find(industry).name
  end

  def seniority_levels_names
    seniority_levels&.join(', ')
  end

  def find_match(first_available: false)
    # search_history = SearchHistory.find(id)
    Expert.find_match(to_search_params.merge(first_available: first_available))
  end

  def notify_all_experts
    experts.each do |_expert|
      notify_user(:expert_enrollment,
                  action: :expert_finished_enrollment,
                  user_id: user.id)
    end
  end
end

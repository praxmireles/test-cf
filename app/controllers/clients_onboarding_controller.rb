# frozen_string_literal: true

# Manages pages and actions related to the client journey on the website
class ClientsOnboardingController < ApplicationController
  def booking; end

  def search; end

  def search_result; end

  def confirmation; end

  def services
    @search_history = current_user.search_histories.new
  end

  def industries
    @search_history = SearchHistory.find(params[:search_history_id])
  end

  def skills
    @search_history = SearchHistory.find(params[:search_history_id])
    @job_functions = JobFunction.all.order('name ASC')
  end

  def descriptions
    @search_history = SearchHistory.find(params[:search_history_id])
    @description_title = case @search_history.service
                         when 'Coaching'
                           'Why are you looking to be coached?'
                         when 'Mentoring'
                           'Why are you looking for mentoring?'
                         else
                           'Please describe in detail what your needs are'
                         end
  end

  def achieve_experiences
    @search_history = SearchHistory.find(params[:search_history_id])
    case @search_history.service
    when 'Coaching'
      @description_title = 'What do you want to achieve from this experience? Personally? Professionally'
    when 'Mentoring'
      @description_title = 'What do you want to achieve'
    end
  end

  def seniority_levels
    @search_history = SearchHistory.find(params[:search_history_id])
  end

  def coaching_type
    @search_history = SearchHistory.find(params[:search_history_id])
  end

  def what_changes
    @search_history = SearchHistory.find(params[:search_history_id])
    @description_title = 'What changes are you looking to make through this process of coaching?'
  end
end

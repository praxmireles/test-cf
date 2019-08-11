# frozen_string_literal: true

# Used for searching for experts based on various criterias
class SearchHistoriesController < ApplicationController
  # Display the search result from the search_params
  def index
    search_history = current_user.search_history.last
    @search_result = Expert.find_match(search_history.to_search_params)
  end

  # Params:
  # - industries [Array]: A list of industries name
  # - job_functions [Array]: A list of job_functions name
  # - seniority_levels [Array]: A list of seniority levels name
  # - skills [Array]: A list of skills name
  def show
    search_history = SearchHistory.find(params[:search_history_id])
    @search_result = Expert.find_match(search_history.to_search_params)
  end

  # Use this to make a search query is submitted
  def create
    search_history = current_user.search_histories.create!(
      search_history_params
    )
    if search_history.save
      redirect_to next_path(params[:current_path], search_history.id)
    else
      redirect_back
    end
  end

  def update
    search_history = current_user.search_histories
                                 .find(params[:search_history_id])
    search_history.update_attributes(search_history_params)
    redirect_to next_path(params[:current_path], search_history.id)
  end

  def previous
    search_history = SearchHistory.find(params[:search_history_id])
    case params[:current_path]
    when 'skills'
      redirect_to industries_path(search_history_id: params[:search_history_id])
    when 'seniority_levels'
      redirect_to skills_path(search_history_id: params[:search_history_id])
    when 'description'
      if search_history.service == 'Coaching'
        redirect_to descriptions_path(
          search_history_id: params[:search_history_id]
        )
      else
        redirect_to seniority_levels_path(
          search_history_id: params[:search_history_id]
        )
      end
    when 'what_changes'
      redirect_to descriptions_path(
        search_history_id: params[:search_history_id]
      )
    when 'achieve_experiences'
      if search_history.service == 'Coaching'
        redirect_to what_changes_path(
          search_history_id: params[:search_history_id]
        )
      else
        redirect_to descriptions_path(
          search_history_id: params[:search_history_id]
        )
      end
    else
      redirect_to services_path
    end
  end

  private

  def next_path(current_path, search_history_id)
    search_history = SearchHistory.find(search_history_id)
    case current_path
    when 'service'
      if search_history.service == 'Coaching'
        coaching_type_path(search_history_id: search_history_id)
      else
        industries_path(search_history_id: search_history_id)
      end
    when 'industries'
      skills_path(search_history_id: search_history_id)
    when 'skills'
      seniority_levels_path(search_history_id: search_history_id)
    when 'seniority_levels'
      descriptions_path(search_history_id: search_history_id)
    when 'description'
      if search_history.service == 'Mentoring' && search_history.characters_complete?
        what_changes_path(search_history_id: search_history_id)
      elsif search_history.service == 'Coaching' && search_history.characters_complete?
        achieve_experiences_path(search_history_id: search_history_id)
      elsif search_history.characters_complete?
        clients_experts_search_path(search_history_id: search_history_id)
      else
        descriptions_path(search_history_id: search_history_id)

      end
    when 'what_changes'
      achieve_experiences_path(search_history_id: search_history_id)
    when 'coaching_type'
      descriptions_path(search_history_id: search_history_id)
    when 'achieve_experiences'
      clients_experts_search_path(search_history_id: search_history_id)
    else
      services_path
    end
  end

  def search_history_params
    params.require(:search_history).permit(
      :achieve_experiences, :description,
      :what_changes, :first_available, :service,
      :coaching_type, :industry,
      functions: [], skills: [],
      seniority_levels: []
    )
  end
end

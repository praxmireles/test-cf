# frozen_string_literal: true

# Manage clients requests with experts to set an appointment
# Note: request is a reserved word in controllers so to declare a request
# variable, we're using appointment_request instead.
class RequestsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:destroy]

  # Send a new request to an Expert
  #
  # Params:
  # - appointment [Hash]
  # -- expert_id [Integer]
  # -- client_id [Integer]
  # -- service_id [Integer]
  # -- day_of_week [String]
  # -- start_date [DateTime]
  # -- search_history_id [Integer]
  #
  # Return [JSON]
  def create
    appointment_request = current_user.pending_requests.new(
      appointment_request_params
    )

    if appointment_request.save
      if appointment_request.initialize_appointment!(appointment_params)
        redirect_to root_path
      else
        render json: {
          status: 500,
          error: 'This expert is not available on the scheduled date'
        }, status: 500
      end
    else
      render json: {
        status: 500, error: appointment_request.errors
      }, status: 500
    end
  end

  # Initialize the Request that need to be edited
  #
  # Params:
  # - request_id : id of the request
  #
  # Returns [Object]
  def edit
    @appointment_request = current_user.requests.find_by(
      id: params[:request_id]
    )

    if @appointment_request.present?
      render json: { appointment_request: @appointment_request, status: 200 }
    else
      render json: { status: 404, layout: false }, status: 404
    end
  end

  # Update a request status to Accept it or Reject it
  #
  # Params:
  # - request_id : id of the request
  #
  # Returns [Object]
  def update
    appointment_request = current_user.pending_requests.find(
      params[:request_id]
    )

    case params[:answer]
    when 'accept'
      if appointment_request.accept!
        redirect_to root_path
      else
        render status: 500
      end
    when 'reject'
      if appointment_request.reject!
        redirect_to root_path
      else
        render status: 500
      end
    else
      render json: { appointment_request: appointment_request, status: 200 }
    end
  end

  # Cancel a request
  #
  # Params:
  # - request_id : id of the request
  #
  # Returns [Object]
  def destroy
    appointment_request = current_user.pending_requests
                                      .find(params[:request_id])
    if appointment_request.cancel!
      redirect_to root_path
    else
      render status: 500
    end
  end

  private

  def appointment_request_params
    params.require(:appointment).permit(
      :user_id, :expert_id, :search_history_id
    )
  end

  def appointment_params
    params.require(:appointment).permit(
      :expert_id,
      :user_id,
      :client_id,
      :service_id,
      :day_of_week,
      :start_date,
      :search_history_id
    )
  end
end

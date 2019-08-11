# Manage Experts's Rating
class RatingsController < ApplicationController
  def show
    appointment = Appointment.find(params[:id])
    @user = if current_user.type == 'Expert'
              User.find(appointment.user_id)
            else
              User.find(appointment.expert_id)
            end
  end

  # rubocop:disable Metrics/AbcSize
  def save
    if current_user.type == 'Expert'
      client_id = params[:user_id].to_i
      expert_id = current_user.id
      user_rated = 'Client'
    else
      client_id = current_user.id
      expert_id = params[:user_id].to_i
      user_rated = 'Expert'
    end

    @rating = "#{user_rated}Rating".constantize.new do |r|
      r.user_id = client_id
      r.expert_id = expert_id
      r.rate = params[:rate]
    end

    @rating.save

    @response = @rating.obtain_response

    respond_to do |format|
      format.json { render json: @response, status: 200 }
    end
  end
  # rubocop:enable Metrics/AbcSize
end

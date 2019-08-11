# frozen_string_literal: true

# Manages pages and action related to the Video Conferene sessions
class VideoConferencesController < ApplicationController
  include Opentokable

  # Create an Opentok Session for the Chat
  #
  # Params:
  # - appointment_id : The appointment id of the session
  #
  # Returns [JSON]
  #
  # example:
  #
  # {
  #  "api_key": "12345678",
  #  "session_id": "123456789",
  #  "token": "1ab2d3e45f67890"
  # }
  #

  # rubocop:disable Metrics/PerceivedComplexity
  def show
    render json: { status: 401, message: 'Login required.' } unless current_user
    puts 'params: show'
    puts params
    @appointment = current_user.in_progress_appointments.find_by(
      id: params[:appointment_id]
    )
    @appointment = current_user.appointments.find_by(
      id: params[:appointment_id]
    )
    if @appointment
      if @appointment.completed_on.present?
        flash.now[:alert] = 'This appointment has ended.'
        redirect_to client_dashboard_path
      else
        create_opentak_for_appointment
        @session_id = @appointment.video_session_uid
        @token = @appointment.video_session_token
        @api_key = ENV['OPENTOK_API_KEY']

        puts 'session_id'
        puts @session_id
        puts 'token'
        puts @token
        puts 'api_key'
        puts @api_key

        # @session_id = "2_MX40NTgyODA2Mn5-MTU1MDc3Nzk4MzI1Mn5vL1BaSDZaS0l1eXpWRmh1UkgrUXlMYUR-UH4"
        # @token = "T1==cGFydG5lcl9pZD00NTgyODA2MiZzaWc9ZmVjYzBkOWM0ZWZhMDUxZTYyZTg5NTk1MzhlNjQ3MGI0MT
        # ZkZmU2NTpzZXNzaW9uX2lkPTJfTVg0ME5UZ3lPREEyTW41LU1UVTFNRGMzTnprNE16STFNbjV2TDFCYVNEWmFTMGwxZVh
        # wV1JtaDFVa2dyVVhsTVlVUi1VSDQmY3JlYXRlX3RpbWU9MTU1MDc3ODAyNyZub25jZT0wLjYxODcwNTE2MDQyOTAyMzcm
        # cm9sZT1wdWJsaXNoZXImZXhwaXJlX3RpbWU9MTU1MDg2NDQyNw=="
        # @api_key = "45828062"
        if current_user.type == 'Client'
          @appointment.update_attributes(client_joined: true)
        else
          @appointment.update_attributes(expert_joined: true)
        end

        # render "show", :layout =>false, status: 200
        render status: 200
      end
    else
      flash.now[:alert] = "No appointment with the id \
      #{params[:appointment_id]} exists"
      # redirect_to root_path
    end
  end
  # rubocop:enable Metrics/PerceivedComplexity

  def destroy
    @appointment = current_user.in_progress_appointments.find_by(
      id: params[:appointment_id]
    )
    @appointment.complete!
  end

  private

  def create_opentak_for_appointment
    return unless @appointment.video_session_uid.nil?
    opentok_session = create_session(@appointment.user_id, @appointment.id)
    @appointment.type = 'InProgressAppointment'
    @appointment.video_session_token = opentok_session[:token]
    @appointment.video_session_uid = opentok_session[:session_id]
    @appointment.save
  end
end

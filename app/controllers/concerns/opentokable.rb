# frozen_string_literal: true

# Handle communication with the Opentok service
module Opentokable
  extend ActiveSupport::Concern

  included do
    def create_opentok_session(type: 'default')
      case type
      # A session that will use the OpenTok Media Server:
      when 'media_mode'
        # There are two options: Relayed and Routed.
        #
        # Use a relayed instead of a routed session, if you have only two
        # participants (or maybe even three) and you are not using archiving.
        #
        # more info: https://tokbox.com/developer/guides/create-session/
        Opentok.create_session media_mode: :relayed
      # A session with a location hint:
      when 'location_hint'
        Opentok.create_session location: '12.34.56.78'
      # A session with automatic archiving (must use the routed media mode):
      when 'automatic_archiving'
        Opentok.create_session archive_mode: :always,
                               media_mode: :routed
      # Create a session that will attempt to transmit streams directly between
      # clients.
      # If clients cannot connect, the session uses the OpenTok TURN server:
      else
        Opentok.create_session
      end
    end

    def generate_token(
      session_or_session_id,
      _options = nil
    )
      # Generate a Token from just a session_id (fetched from a database)
      if session_or_session_id.is_a? String
        Opentok.generate_token session_id
      else
        session_or_session_id.generate_token
      end
    end

    # Store this sessionId in the database for later use:
    def create_session(client_id, appointment_id)
      opentok_session = create_opentok_session(type: 'media_mode')
      return false unless opentok_session.present?

      client = Client.find_by(id: client_id)
      appointment = client.appointments.find_by(id: appointment_id)
      token = generate_token(opentok_session)
      appointment.video_session_uid = opentok_session.session_id
      appointment.video_session_token = token
      appointment.save(validate: false)
      { api_key: Opentok.api_key, session_id: appointment.video_session_uid, token: appointment.video_session_token }
    end
  end
end

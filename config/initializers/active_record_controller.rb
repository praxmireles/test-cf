module ActiveRecord
  # Class Base
  class Base
    # Super power for Active Record for control to insert / update
    # Use cases:
    #
    # @response = [Active Record Object].obtain_response
    # respond_to do |format|
    #   format.js { }    <- Execute Java script: sammple MWPApp.showResponse('<%= @response.to_s.html_safe %>')
    # end
    #
    # For Ajax Respose
    # respond_to do |format|
    #   format.json { render json: [Active Record Object].obtain_response,status: :ok }
    # end

    def obtain_response
      response = {
        'success' => false,
        'data' => [],
        'total' => 0,
        'message_success' => '',
        'message_error' => '',
        'title' => ''
      }
      if errors.any?
        response[:success] = false
        errors.full_messages.each do |message|
          response['message_error'] = response['message_error'] + message
        end
        response['title'] = response['title'] + '. Fail!'
      else
        response[:data] = self
        response[:success] = true
        response['message_success'] = 'Done'
        response['title'] = response['title'] + '. Success!'
      end
      response.to_json
    end
  end
end

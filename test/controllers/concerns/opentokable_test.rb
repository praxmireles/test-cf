require 'test_helper'

class OpentokableTest < ActiveSupport::TestCase
  include Opentokable
  let(:client) { create(:client) }
  let(:expert) { create(:expert) }
  let(:service) { create(:service) }
  let(:appointment) { create(:appointment, expert_id: expert.id, user_id: client.id, service_id: service.id) }
  def test_create_opentok_session
    create_opentok_session
  end

  def test_create_session
    create_session(client.id, appointment.id)
  end
end

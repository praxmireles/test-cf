require 'test_helper'

class ClientsOnboardingHelperTest < ActiveSupport::TestCase
  include ClientsOnboardingHelper
  let(:user) { create(:user) }
  let(:service) { create(:service) }
  let(:search_history) { create(:search_history, user_id: user.id, service: service) }
  def test_show_service_name
    show_service_name(search_history.service)
  end
end

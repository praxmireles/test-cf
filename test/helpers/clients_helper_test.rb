require 'test_helper'

class ClientsHelperTest < ActiveSupport::TestCase
  include ClientsHelper
  include ApplicationHelper
  let(:service) { create(:service) }
  let(:expert) { create(:expert) }
  let(:client) { create(:user) }
  let(:skill) { create(:skill) }
  let(:profile_skill) { create(:profile_skill, skill_id: skill.id, profile_id: expert.profile.id) }
  let(:search_history) { create(:search_history, user_id: client.id) }
  let(:appointment) { create(:appointment, start_date: Date.today, service_id: service.id, user_id: client.id) }
  # def test_date_to_time
  #   actual = date_to_time(set_in_timezone(appointment.start_date, client.id))
  #   # assert_equal '18:00', actual
  # end

  def test_matching_skills
    profile_skill
    matching_skills(search_history.id, expert.skills)
  end
end

require 'test_helper'

describe AppointmentSuggest do
  let(:appointment_suggest) { AppointmentSuggest.new }

  it 'must be valid' do
    value(appointment_suggest).must_be :valid?
  end
end

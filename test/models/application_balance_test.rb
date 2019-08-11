require 'test_helper'

describe ApplicationBalance do
  let(:application_balance) { ApplicationBalance.new }

  it 'must be valid' do
    value(application_balance).must_be :valid?
  end
end

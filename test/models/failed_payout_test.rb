require 'test_helper'

describe FailedPayout do
  let(:failed_payout) { FailedPayout.new }
  it 'must be valid' do
    value(failed_payout).must_be :valid?
  end
end

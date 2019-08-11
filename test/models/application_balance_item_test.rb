require 'test_helper'

describe ApplicationBalanceItem do
  let(:application_balance_item) { ApplicationBalanceItem.new }

  it 'must be valid' do
    value(application_balance_item).must_be :valid?
  end
end

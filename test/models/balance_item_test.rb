require 'test_helper'

describe BalanceItem do
  let(:balance_item) { BalanceItem.new }

  it 'must be valid' do
    value(balance_item).must_be :valid?
  end
end

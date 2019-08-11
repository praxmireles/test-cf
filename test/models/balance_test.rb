require 'test_helper'

describe Balance do
  let(:balance) { Balance.new }

  it 'must be valid' do
    value(balance).must_be :valid?
  end
end

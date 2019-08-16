require 'test_helper'
describe FailedPayment do
  let(:failed_payment) { FailedPayment.new }
  it 'must be valid' do
    value(failed_payment).must_be :valid?
  end
end

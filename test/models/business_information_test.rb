require 'test_helper'

describe BusinessInformation do
  let(:business_information) { BusinessInformation.new }

  it 'must be valid' do
    value(business_information).must_be :valid?
  end
end

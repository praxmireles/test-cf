require 'test_helper'

describe Configuration do
  let(:configuration) { Configuration.new }

  it 'must be valid' do
    value(configuration).must_be :valid?
  end
end

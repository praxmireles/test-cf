require 'test_helper'

describe CoachingType do
  let(:coaching_type) { CoachingType.new }

  it 'must be valid' do
    value(coaching_type).must_be :valid?
  end
end

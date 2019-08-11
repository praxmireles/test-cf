require 'test_helper'

describe Applicant do
  let(:applicant) { Applicant.new }

  it 'must be valid' do
    value(applicant).must_be :valid?
  end
end

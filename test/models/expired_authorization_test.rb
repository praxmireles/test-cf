require 'test_helper'

describe ExpiredAuthorization do
  let(:expired_authorization) { ExpiredAuthorization.new }

  it 'must be valid' do
    value(expired_authorization).must_be :valid?
  end
end

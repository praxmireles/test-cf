require 'test_helper'

describe SharedDocument do
  let(:shared_document) { SharedDocument.new }

  it 'must be valid' do
    value(shared_document).must_be :valid?
  end
end

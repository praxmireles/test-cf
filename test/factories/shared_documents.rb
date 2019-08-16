FactoryBot.define do
  factory :shared_document do
    user nil
    appointment nil
    name 'MyString'
    type ''
    file 'MyString'
    owned_by_client false
  end
end

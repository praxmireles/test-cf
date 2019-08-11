FactoryBot.define do
  factory :expired_authorization do
    payment_id 1
    appointment_id 1
    refund false
  end
end

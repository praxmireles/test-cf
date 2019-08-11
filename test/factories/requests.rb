# frozen_string_literal: true

FactoryBot.define do
  factory :request do
    rescheduled false
  end
  factory :pending_request, parent: :request, class: 'PendingRequest' do
    type { 'PendingRequest' }
  end

  factory :accepted_request, parent: :request, class: 'AcceptedRequest' do
    type { 'AcceptedRequest' }
  end

  factory :rejected_request, parent: :request, class: 'RejectedRequest' do
    type { 'RejectedRequest' }
  end

  factory :cancelled_request, parent: :request, class: 'CancelledRequest' do
    type { 'CancelledRequest' }
  end
end

require 'administrate/base_dashboard'

class ScheduledAppointmentDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    client: Field::BelongsTo,
    service: Field::BelongsTo,
    expert: Field::BelongsTo,
    request: Field::BelongsTo,
    search_history: Field::BelongsTo,
    appointment_packs: Field::HasMany,
    invoice: Field::HasOne,
    payment: Field::HasOne,
    rating: Field::HasOne,
    id: Field::Number,
    user_id: Field::Number,
    type: Field::String,
    first_available: Field::Number,
    video_session_uid: Field::String,
    video_session_token: Field::String,
    cancel_reason: Field::String,
    description: Field::String,
    stripe_charge_uid: Field::String,
    subject: Field::String,
    cancelled_on: Field::DateTime,
    cancelled: Field::Boolean,
    duration_in_min: Field::Number,
    time_spent_in_min: Field::Number,
    offline: Field::Boolean,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    start_date: Field::DateTime,
    end_date: Field::DateTime,
    cancelled_by: Field::String,
    price: Field::Number.with_options(decimals: 2),
    completed_on: Field::DateTime,
    scheduled_on: Field::DateTime,
    introduction: Field::Boolean,
    day_of_week: Field::String,
    close_on: Field::DateTime,
    close: Field::Boolean
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
    client
    service
    expert
    request
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    client
    service
    expert
    request
    search_history
    appointment_packs
    invoice
    payment
    rating
    id
    user_id
    type
    first_available
    video_session_uid
    video_session_token
    cancel_reason
    description
    stripe_charge_uid
    subject
    cancelled_on
    cancelled
    duration_in_min
    time_spent_in_min
    offline
    created_at
    updated_at
    start_date
    end_date
    cancelled_by
    price
    completed_on
    scheduled_on
    introduction
    day_of_week
    close_on
    close
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
    client
    service
    expert
    request
    search_history
    appointment_packs
    invoice
    payment
    rating
    user_id
    type
    first_available
    video_session_uid
    video_session_token
    cancel_reason
    description
    stripe_charge_uid
    subject
    cancelled_on
    cancelled
    duration_in_min
    time_spent_in_min
    offline
    start_date
    end_date
    cancelled_by
    price
    completed_on
    scheduled_on
    introduction
    day_of_week
    close_on
    close
  ].freeze

  # Overwrite this method to customize how scheduled appointments are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(scheduled_appointment)
  #   "ScheduledAppointment ##{scheduled_appointment.id}"
  # end
end

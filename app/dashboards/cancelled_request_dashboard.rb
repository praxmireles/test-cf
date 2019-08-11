require 'administrate/base_dashboard'

class CancelledRequestDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    client: Field::BelongsTo,
    expert: Field::BelongsTo,
    appointment: Field::HasOne,
    id: Field::Number,
    user_id: Field::Number,
    type: Field::String,
    rescheduled: Field::Boolean,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    search_history_id: Field::Number
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
    client
    expert
    appointment
    id
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    client
    expert
    appointment
    id
    user_id
    type
    rescheduled
    created_at
    updated_at
    search_history_id
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
    client
    expert
    appointment
    user_id
    type
    rescheduled
    search_history_id
  ].freeze

  # Overwrite this method to customize how cancelled requests are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(cancelled_request)
  #   "CancelledRequest ##{cancelled_request.id}"
  # end
end

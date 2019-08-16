require 'administrate/base_dashboard'

class CancelledAppointmentPackDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    user: Field::BelongsTo,
    client: Field::BelongsTo,
    expert: Field::BelongsTo,
    service: Field::BelongsTo,
    appointments: Field::HasMany,
    id: Field::Number,
    type: Field::String,
    price: Field::Number.with_options(decimals: 2),
    description: Field::Text,
    name: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
    user
    client
    expert
    service
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    user
    client
    expert
    service
    appointments
    id
    type
    price
    description
    name
    created_at
    updated_at
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
    user
    client
    expert
    service
    appointments
    type
    price
    description
    name
  ].freeze

  # Overwrite this method to customize how cancelled appointment packs are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(cancelled_appointment_pack)
  #   "CancelledAppointmentPack ##{cancelled_appointment_pack.id}"
  # end
end

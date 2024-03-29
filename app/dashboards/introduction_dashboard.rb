require 'administrate/base_dashboard'

class IntroductionDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    service: Field::BelongsTo,
    id: Field::Number,
    name: Field::String,
    duration_in_min: Field::Number,
    price: Field::Number.with_options(decimals: 2),
    created_at: Field::DateTime,
    updated_at: Field::DateTime
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
    service
    id
    name
    duration_in_min
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    service
    id
    name
    duration_in_min
    price
    created_at
    updated_at
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
    service
    name
    duration_in_min
    price
  ].freeze

  # Overwrite this method to customize how introductions are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(introduction)
  #   "Introduction ##{introduction.id}"
  # end
end

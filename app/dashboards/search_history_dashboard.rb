require 'administrate/base_dashboard'

class SearchHistoryDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    client: Field::BelongsTo,
    appointments: Field::HasMany,
    id: Field::Number,
    user_id: Field::Number,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    first_available: Field::Boolean,
    service: Field::String,
    functions: Field::String,
    skills: Field::String,
    seniority_level: Field::String,
    coaching_type: Field::String
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
    client
    appointments
    id
    user_id
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    client
    appointments
    id
    user_id
    created_at
    updated_at
    first_available
    service
    functions
    skills
    seniority_level
    coaching_type
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
    client
    appointments
    user_id
    first_available
    service
    functions
    skills
    seniority_level
    coaching_type
  ].freeze

  # Overwrite this method to customize how search histories are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(search_history)
  #   "SearchHistory ##{search_history.id}"
  # end
end

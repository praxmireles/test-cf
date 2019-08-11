require 'administrate/base_dashboard'

class ProjectInMindDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    appointment_packs: Field::HasMany,
    introduction: Field::HasOne,
    id: Field::Number,
    type: Field::String,
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
    appointment_packs
    introduction
    id
    type
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    appointment_packs
    introduction
    id
    type
    duration_in_min
    price
    created_at
    updated_at
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
    appointment_packs
    introduction
    type
    duration_in_min
    price
  ].freeze

  # Overwrite this method to customize how project in minds are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(project_in_mind)
  #   "ProjectInMind ##{project_in_mind.id}"
  # end
end

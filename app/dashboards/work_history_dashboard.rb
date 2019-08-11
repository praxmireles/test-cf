require 'administrate/base_dashboard'

class WorkHistoryDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    user: Field::BelongsTo,
    id: Field::Number,
    title: Field::String,
    company: Field::String,
    location: Field::String,
    from_date: Field::DateTime,
    to_date: Field::DateTime,
    present: Field::Boolean,
    linkedin_import: Field::Boolean,
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
    id
    title
    company
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    user
    id
    title
    company
    location
    from_date
    to_date
    present
    linkedin_import
    created_at
    updated_at
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
    user
    title
    company
    location
    from_date
    to_date
    present
    linkedin_import
  ].freeze

  # Overwrite this method to customize how work histories are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(work_history)
  #   "WorkHistory ##{work_history.id}"
  # end
end

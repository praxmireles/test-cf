require 'administrate/base_dashboard'

class NewNotificationDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    user: Field::BelongsTo,
    id: Field::Number,
    type: Field::String,
    message: Field::Text,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    action: Field::String,
    link: Field::String
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
    user
    id
    type
    message
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    user
    id
    type
    message
    created_at
    updated_at
    action
    link
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
    user
    type
    message
    action
    link
  ].freeze

  # Overwrite this method to customize how new notifications are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(new_notification)
  #   "NewNotification ##{new_notification.id}"
  # end
end

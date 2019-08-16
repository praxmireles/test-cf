require 'administrate/base_dashboard'

class ContactInformationDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    user: Field::BelongsTo,
    id: Field::Number,
    primary_phone: Field::String,
    secondary_phone: Field::String,
    primary_mobile: Field::String,
    secondary_mobile: Field::String,
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
    primary_phone
    secondary_phone
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    user
    id
    primary_phone
    secondary_phone
    primary_mobile
    secondary_mobile
    created_at
    updated_at
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
    user
    primary_phone
    secondary_phone
    primary_mobile
    secondary_mobile
  ].freeze

  # Overwrite this method to customize how contact informations are displayed
  # across all pages of the admin dashboard.
  #
  def display_resource(contact_information)
    primary_phone = "<b>Primary Phone:</b> #{contact_information.primary_phone}".html_safe
    mobile_phone = "<b>Mobile Phone:</b> #{contact_information.primary_mobile}".html_safe

    if contact_information.primary_phone.present? && contact_information.primary_mobile.present?
      primary_phone + ' | ' + mobile_phone
    elsif contact_information.primary_phone.present?
      primary_phone
    else
      'N/A'
    end
  end
end

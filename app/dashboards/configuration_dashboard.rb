require 'administrate/base_dashboard'

class ConfigurationDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    express_advice_price: Field::Number.with_options(decimals: 2),
    mentoring_price: Field::Number.with_options(decimals: 2),
    coaching_price: Field::Number.with_options(decimals: 2),
    mentoring_introduction_price: Field::Number.with_options(decimals: 2),
    coaching_introduction_price: Field::Number.with_options(decimals: 2),
    confirmation_max_days: Field::Number,
    created_at: Field::DateTime,
    updated_at: Field::DateTime
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
    id
    express_advice_price
    mentoring_price
    coaching_price
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    id
    express_advice_price
    mentoring_price
    coaching_price
    mentoring_introduction_price
    coaching_introduction_price
    confirmation_max_days
    created_at
    updated_at
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
    express_advice_price
    mentoring_price
    coaching_price
    mentoring_introduction_price
    coaching_introduction_price
    confirmation_max_days
  ].freeze

  # Overwrite this method to customize how configurations are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(configuration)
  #   "Configuration ##{configuration.id}"
  # end
end

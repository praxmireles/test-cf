require 'administrate/base_dashboard'

class PaymentDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    user: Field::BelongsTo,
    appointment: Field::BelongsTo,
    id: Field::Number,
    appointment_pack_id: Field::Number,
    amount: Field::Number.with_options(decimals: 2),
    card_last4: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    charge_id: Field::String,
    brand: Field::String,
    exp_month: Field::String,
    exp_year: Field::String
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
    user
    appointment
    id
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    user
    appointment
    id
    appointment_pack_id
    amount
    card_last4
    created_at
    updated_at
    charge_id
    brand
    exp_month
    exp_year
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
    user
    appointment
    appointment_pack_id
    amount
    card_last4
    charge_id
    brand
    exp_month
    exp_year
  ].freeze

  # Overwrite this method to customize how payments are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(payment)
  #   "Payment ##{payment.id}"
  # end
end

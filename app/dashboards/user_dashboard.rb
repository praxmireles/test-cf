require 'administrate/base_dashboard'

class UserDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    billing: Field::HasOne,
    contact_information: Field::HasOne,
    appointment_packs: Field::HasMany,
    requests: Field::HasMany,
    ratings: Field::HasMany,
    availabilities: Field::HasMany,
    access_tokens: Field::HasMany,
    appointments: Field::HasMany,
    coachings: Field::HasMany.with_options(class_name: 'Service'),
    express_advices: Field::HasMany.with_options(class_name: 'Service'),
    mentorings: Field::HasMany.with_options(class_name: 'Service'),
    project_in_minds: Field::HasMany.with_options(class_name: 'Service'),
    id: Field::Number,
    type: Field::String,
    first_name: Field::String,
    last_name: Field::String,
    username: Field::String,
    active: Field::Boolean,
    email: Field::String,
    job: Field::String,
    company: Field::String,
    facebook_url: Field::String,
    google_url: Field::String,
    linkedin_url: Field::String,
    avatar: Field::String,
    provider: Field::String,
    stripe_customer_id: Field::String,
    hourly_rate: Field::Number.with_options(decimals: 2),
    accepted_privacy_policy: Field::Boolean,
    accepted_policy_on: Field::DateTime,
    facebook_uid: Field::String,
    linkedin_uid: Field::String,
    completed_onboarding: Field::Boolean,
    location: Field::String,
    timezone_id: Field::Number,
    coach: Field::Boolean,
    last_sign_in_ip: Field::String,
    current_sign_in_ip: Field::String,
    last_sign_in_at: Field::DateTime,
    sign_in_count: Field::Number,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    current_card_id: Field::Number,
    locale: Field::String,
    current_onboarding_step: Field::String
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
    id
    first_name
    last_name
    email
    type
    contact_information
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    billing
    contact_information
    appointment_packs
    requests
    ratings
    availabilities
    access_tokens
    appointments
    coachings
    express_advices
    mentorings
    project_in_minds
    id
    type
    first_name
    last_name
    username
    active
    email
    job
    company
    facebook_url
    google_url
    linkedin_url
    avatar
    provider
    stripe_customer_id
    hourly_rate
    accepted_privacy_policy
    accepted_policy_on
    facebook_uid
    linkedin_uid
    completed_onboarding
    location
    timezone_id
    coach
    last_sign_in_ip
    current_sign_in_ip
    last_sign_in_at
    sign_in_count
    created_at
    updated_at
    current_card_id
    locale
    current_onboarding_step
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
    billing
    contact_information
    access_tokens
    appointments
    coachings
    express_advices
    mentorings
    project_in_minds
    type
    first_name
    last_name
    username
    active
    email
    job
    company
    facebook_url
    google_url
    linkedin_url
    avatar
    provider
    stripe_customer_id
    hourly_rate
    accepted_privacy_policy
    accepted_policy_on
    facebook_uid
    linkedin_uid
    completed_onboarding
    location
    timezone_id
    coach
    last_sign_in_ip
    current_sign_in_ip
    last_sign_in_at
    sign_in_count
    current_card_id
    locale
    current_onboarding_step
  ].freeze

  # Overwrite this method to customize how users are displayed
  # across all pages of the admin dashboard.
  #
  def display_resource(user)
    # "User ##{user.id}"
    "#{user.first_name} #{user.last_name} | #{user.type}"
  end
end

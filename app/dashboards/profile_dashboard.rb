require 'administrate/base_dashboard'

class ProfileDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    user: Field::BelongsTo,
    expert: Field::BelongsTo,
    job_functions: Field::HasMany.with_options(class_name: 'ProfileJobFunction'),
    skills: Field::HasMany.with_options(class_name: 'ProfileSkill'),
    seniority_levels: Field::HasMany.with_options(class_name: 'ProfileSeniorityLevel'),
    industries: Field::HasMany.with_options(class_name: 'ProfileIndustry'),
    languages: Field::HasMany.with_options(class_name: 'ProfileLanguage'),
    id: Field::Number,
    resume: Field::String,
    about: Field::Text,
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
    expert
    job_functions
    skills
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    user
    expert
    job_functions
    skills
    seniority_levels
    industries
    languages
    id
    resume
    about
    created_at
    updated_at
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
    user
    expert
    job_functions
    skills
    seniority_levels
    industries
    languages
    resume
    about
  ].freeze

  # Overwrite this method to customize how profiles are displayed
  # across all pages of the admin dashboard.
  #
  def display_resource(profile)
    "#{profile.user.fullname}'s Profile"
  end
end

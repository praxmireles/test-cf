require 'administrate/base_dashboard'

class ProfileSkillDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    skill: Field::BelongsTo,
    profile: Field::BelongsTo,
    user: Field::HasOne,
    expert: Field::HasOne,
    id: Field::Number,
    created_at: Field::DateTime,
    updated_at: Field::DateTime
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
    skill
    profile
    user
    expert
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    skill
    profile
    user
    expert
    id
    created_at
    updated_at
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
    skill
    profile
    user
    expert
  ].freeze

  # Overwrite this method to customize how profile skills are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(profile_skill)
  #   "ProfileSkill ##{profile_skill.id}"
  # end
end

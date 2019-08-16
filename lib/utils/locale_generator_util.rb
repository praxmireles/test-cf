# This library help generate the YML file for
# - Industries
# - Skills
# - Job Functions
# - Seniority Level
#
# Usage:
#   require_relative 'lib/utils/locale_generator_util.rb'
#    LocaleGeneratorUtil.
module LocaleGeneratorUtil
  SEED_DATA_CATEGORY = %w[Industry Skill JobFunction SeniorityLevel CoachingType].freeze
  PARENT_LOCALES = {
    'Industry': 'all_industries',
    'Skill': 'all_skills',
    'JobFunction': 'all_job_functions',
    'SeniorityLevel': 'all_seniority_levels',
    'CoachingType': 'all_coaching_types'
  }.freeze

  class << self
    # Generate YML value for language yml file (en.yml and es.yml)
    def generate_yml(is_empty = false)
      SEED_DATA_CATEGORY.each do |category|
        collection = category.constantize.all
        print_locale_for_yml(collection, is_empty)
      end
    end

    def update_all_seed_category
      SEED_DATA_CATEGORY.each do |category|
        collection = category.constantize.all
        update_models_locale(collection)
      end
    end

    # Update the locale attribute of a model with its locale value
    def update_models_locale(collection)
      if collection.first.respond_to? :locale
        collection.each do |record|
          locale = sanitize_locale(record.name)
          record.update_attributes(locale: "#{PARENT_LOCALES[record.class.to_s.to_sym]}.#{locale}")
        end
      else
        puts "[INVALID MODEL] couldn't find a locale column"
      end
    end

    def print_locale_for_yml(collection, without_english_translation = false)
      collection.each do |record|
        locale = sanitize_locale(record.name)
        puts "#{locale}: #{record.name}" unless without_english_translation
        puts "#{record.name}:" if without_english_translation
      end
    end

    private

    def sanitize_locale(value)
      value.gsub('&', 'and')
           .gsub('-', '__')
           .tr(' ', '_')
           .gsub('(', '__')
           .delete(')')
           .delete(',')
           .gsub('/', 'or')
           .downcase
    end
  end
end

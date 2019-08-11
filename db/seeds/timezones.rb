# frozen_string_literal: true

# Populate Timezone Table
module TimeZoner
  include ActiveSupport

  def self.populate
    TimeZone.all.each do |timezone|
      timezone_name = timezone.tzinfo.to_s.split(' - ')[1]

      timezone = Timezone.find_or_create_by!(
        name: timezone_name,
        utc_difference: timezone.utc_offset / 3600,
        continent:  timezone.tzinfo.to_s.split(' - ')[0]
      )

      if timezone.save
        puts " [ ✅ ] #{timezone.name}"
      else
        puts " [ 🔴 ] #{timezone_name}"
      end
    end
  end
end

puts 'SEEDING TIMEZONES...'

TimeZoner.populate

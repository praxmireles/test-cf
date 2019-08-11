# frozen_string_literal: true

puts 'SEEDING SENIORITY LEVELS...'

seniority_levels = [
  { rank:  1, short_name: 'CEO', name: 'Chief Executive Officer' },
  { rank:  2, short_name: 'President', name: 'President' },
  { rank:  3, short_name: 'C-Suite', name: 'Chief Executive - Suite' },
  { rank:  4, short_name: 'General Manager', name: 'General Manager' },
  { rank:  5, short_name: 'Managing Director', name: 'Managing Director' },
  { rank:  6, short_name: 'SVP', name: 'Senior Vice President' },
  { rank:  7, short_name: 'VP', name: 'Vice President' },
  { rank:  8, short_name: 'Executive Director', name: 'Executive Director' },
  { rank:  9, short_name: 'Managing Partner', name: 'Managing Partner' },
  { rank: 10, short_name: 'Director', name: 'Director' },
  { rank: 11, short_name: 'Partner', name: 'Partner' },
  { rank: 12, short_name: 'Manager', name: 'Manager' }
]

seniority_levels.each do |seniority|
  seniority_level = SeniorityLevel.find_or_create_by!(
    rank: seniority[:rank],
    name: seniority[:name],
    short_name: seniority[:short_name]
  )

  if seniority_level.save
    puts " [ ✅ ] #{seniority_level.name}"
  else
    puts " [ 🔴 ] #{seniority[:name]}"
  end
end

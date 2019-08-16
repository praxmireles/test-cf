# frozen_string_literal: true

puts 'SEEDING WORK INDUSTRIES...'

spreadsheet = Roo::Excelx.new(
  "#{Rails.root}/app/documents/seniority_and_industries.xlsx"
).sheet(1)

from_row = 3
last_row = spreadsheet.last_row

(from_row..last_row).each do |row|
  industry_name = spreadsheet.row(row)[0]
  industry = Industry.find_or_create_by!(name: industry_name)

  if industry.save
    puts " [ ✅ ] #{industry.name}"
  else
    puts " [ 🔴 ] #{industry_name}"
  end
end

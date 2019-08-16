# frozen_string_literal: true

puts 'SEEDING SKILLS...'

spreadsheet = Roo::Excelx.new(
  "#{Rails.root}/app/documents/functions_and_skills.xlsx"
)

from_column = 2
to_column = spreadsheet.last_column

Skill.transaction do
  (from_column..to_column).each do |column|
    column_index = column - 1
    function_name = spreadsheet.row(1)[column_index]
    puts "______ #{function_name.upcase}"

    if function_name
      job_function = JobFunction.find_by_name(function_name)
      column_values = spreadsheet.column(column)

      from_row = 2
      last_row = column_values.compact.count

      (from_row..last_row).each do |row|
        skill_name = spreadsheet.row(row)[column_index]

        skill = job_function.skills.find_or_create_by!(name: skill_name)

        if skill.save
          puts "----- [ ✅ ] #{skill.name}"
        else
          puts "----- [ 🔴 ] #{skill_name}"
        end
      end
    else
      puts "-- No function at column:#{column} row:#{row}"
    end
  end
end

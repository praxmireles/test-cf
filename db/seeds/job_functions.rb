# frozen_string_literal: true

puts 'SEEDING WORK FUNCTIONS...'

spreadsheet = Roo::Excelx.new(
  "#{Rails.root}/app/documents/functions_and_skills.xlsx"
)

# functions = [
#   'Marketing Tools and Automation',
#   'Operations',
#   'Strategy And Planning',
#   'Company Leader',
#   'Legal',
#   'Procurement',
#   'Finance Accounting',
#   'Risk compliance',
#   'Technology Software',
#   'Human resources',
#   'Sales and business development',
#   'Coaching'
# ]

# functions.each do |function|
#   JobFunction.find_or_create_by!(
#     name: function
#   )
# end

from_column = 2
to_column = spreadsheet.last_column

JobFunction.transaction do
  (from_column..to_column).each do |column|
    column_index = column - 1
    function_name = spreadsheet.row(1)[column_index]

    if function_name
      job_function = JobFunction.find_or_create_by!(name: function_name)

      if job_function.save
        puts " [ ✅ ] #{job_function.name}"
      else
        puts " [ 🔴 ] #{function_name}"
      end
    else
      puts "-- No function at column:#{column} row:#{row}"
    end
  end
end

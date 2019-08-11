# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

Rake.application['db:seed:job_functions'].invoke
Rake.application['db:seed:industries'].invoke
Rake.application['db:seed:languages'].invoke
Rake.application['db:seed:seniority_levels'].invoke
Rake.application['db:seed:skills'].invoke
Rake.application['db:seed:timezones'].invoke
Rake.application['db:seed:services'].invoke
Rake.application['db:seed:configuration'].invoke
Rake.application['db:seed:add_new_timezone'].invoke
Rake.application['db:seed:coaching_types'].invoke
puts 'SEEDING is complete.'

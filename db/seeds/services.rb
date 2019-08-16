services_config_path = Rails.root.join('config', 'services.yml')
services_config = YAML.load_file(services_config_path)

puts 'SEEDING SERVICES...'

express_advice = ExpressAdvice.find_or_initialize_by(
  duration_in_min: services_config['express_advice']['duration_in_min'],
  price: services_config['express_advice']['price']
)
if express_advice.save
  puts 'Express Advice Service [ ✅ ]'
else
  puts 'Express Advice Service [ 🔴 ]'
end

mentoring = Mentoring.find_or_initialize_by(
  duration_in_min: services_config['mentoring']['duration_in_min'],
  price: services_config['mentoring']['price']
)

if mentoring.save
  puts 'Mentoring Service [ ✅ ]'
else
  puts 'Mentoring Service [ 🔴 ]'
end

if mentoring.introduction.present?
  puts '-- Skipped Mentoring Introduction | Already Exist [ ❎ ]'
else

  mentoring_introduction = mentoring.build_introduction(
    name: 'Mentoring Introduction',
    duration_in_min: services_config['mentoring']['introduction']\
    ['duration_in_min'],
    price: services_config['mentoring']['introduction']['price']
  )

  if mentoring_introduction.save
    puts '-- Mentoring Introduction [ ✅ ]'
  else
    puts '-- Mentoring Introduction [ 🔴 ]'
  end
end

coaching = Coaching.new(
  duration_in_min: services_config['coaching']['duration_in_min'],
  price: services_config['coaching']['price']
)

if coaching.save
  puts 'Coaching Service [ ✅ ]'
else
  puts 'Coaching Service [ 🔴 ]'
end

if coaching.introduction.present?
  puts '-- Skipped Mentoring Introduction | Already Exists [ ❎ ]'
else
  coaching_introduction = coaching.create_introduction(
    name: 'Coaching Introduction',
    duration_in_min: services_config['coaching']['introduction']\
    ['duration_in_min'],
    price: services_config['coaching']['introduction']['price']
  )

  if coaching_introduction.save
    puts '-- Mentoring Introduction [ ✅ ]'
  else
    puts '-- Mentoring Introduction [ 🔴 ]'
  end
end

project_in_mind = ProjectInMind.create!(
  duration_in_min: services_config['project_in_mind']['duration_in_min'],
  price: services_config['project_in_mind']['price']
)

if project_in_mind.save
  puts 'Project in Mind Service [ ✅ ]'
else
  puts 'Project in Mind Service [ 🔴 ]'
end

if project_in_mind.introduction.present?
  puts '-- Skipped Project in Mind Introduction | Already Exists [ ❎ ]'
else
  project_in_mind_introduction = project_in_mind.create_introduction(
    name: 'Project In Mind Introduction',
    duration_in_min: services_config['project_in_mind']['introduction']\
    ['duration_in_min'],
    price: services_config['project_in_mind']['introduction']['price']
  )

  if project_in_mind_introduction.save
    puts '-- Project in Mind Introduction [ ✅ ]'
  else
    puts '-- Project in Mind Introduction [ 🔴 ]'
  end
end

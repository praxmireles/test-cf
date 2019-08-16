[
  'One on One Coaching Executives',
  'Business Coaching',
  'Ontological Coaching',
  'Career Coaching',
  'Performance Coaching',
  'Newly Assigned Leader Coaching',
  'Succession Coaching',
  'Coaching for Directors',
  'Coaching for Managers',
  'Coaching for Entrepreneurs',
  'Coaching for Students'
].each do |coaching_type|
  CoachingType.find_or_create_by!(name: coaching_type)
end

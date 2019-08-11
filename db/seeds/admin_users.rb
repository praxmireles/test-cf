SuperAdmin.create!(
  first_name: 'Super',
  last_name: 'Admin',
  email: ENV['ADMIN_EMAIL'],
  password: ENV['ADMIN_PASSWORD']
)

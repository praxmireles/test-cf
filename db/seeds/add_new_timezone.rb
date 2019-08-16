# frozen_string_literal: true

puts 'SEEDING NEW TIMEZONES...'
timezones = [
  { name: 'Accra', utc_difference: 1, continent: 'Asia' },
  { name: 'Addis Ababa', utc_difference: 3, continent: 'Africa' },
  { name: 'Amman', utc_difference: 3, continent: 'Europe' },
  { name: 'Anadyr', utc_difference: 12, continent: 'Asia' },
  { name: 'Anchorage', utc_difference: -8, continent: 'America' },
  { name: 'Ankara', utc_difference: 3, continent: 'Asia' },
  { name: 'Antananarivo', utc_difference: 3, continent: 'Africa' },
  { name: 'Asuncion', utc_difference: -4, continent: 'America' },
  { name: 'Atlanta', utc_difference: -4, continent: 'America' },
  { name: 'Bangalore', utc_difference: 5, continent: 'Asia' },
  { name: 'Beirut', utc_difference: 3, continent: 'Europe' },
  { name: 'Boston', utc_difference: -4, continent: 'America' },
  { name: 'Brasilia', utc_difference: -3, continent: 'America' },
  { name: 'Calgary', utc_difference: -6, continent: 'America' },
  { name: 'Canberra', utc_difference: 10, continent: 'Oceania' },
  { name: 'Cape Towm', utc_difference: 2, continent: 'Africa' },
  { name: 'Dallas', utc_difference: -5, continent: 'America' },
  { name: 'Detroit', utc_difference: -4, continent: 'America' },
  { name: 'Doha', utc_difference: 3, continent: 'Asia' },
  { name: 'Dubai', utc_difference: 4, continent: 'Asia' },
  { name: 'Edmonton', utc_difference: -6, continent: 'America' },
  { name: 'Frankfurt', utc_difference: 2, continent: 'Europe' },
  { name: 'Hanoi', utc_difference: 7, continent: 'Asia' },
  { name: 'Habana', utc_difference: -4, continent: 'America' },
  { name: 'Houston', utc_difference: -5, continent: 'America' },
  { name: 'Islamabad', utc_difference: 5, continent: 'Asia' },
  { name: 'Khartoum', utc_difference: 2, continent: 'Africa' },
  { name: 'Kingston', utc_difference: -5, continent: 'America' },
  { name: 'Kinshasa', utc_difference: 1, continent: 'Africa' },
  { name: 'Lagos', utc_difference: 1, continent: 'Africa' },
  { name: 'Lahore', utc_difference: 5, continent: 'Asia' },
  { name: 'Las Vegas', utc_difference: -7, continent: 'America' },
  { name: 'Lima', utc_difference: -5, continent: 'America' },
  { name: 'Managua', utc_difference: -6, continent: 'America' },
  { name: 'Manila', utc_difference: 8, continent: 'Asia' },
  { name: 'Miami', utc_difference: -4, continent: 'America' },
  { name: 'Minneapolis', utc_difference: -5, continent: 'America' },
  { name: 'Montreal', utc_difference: -4, continent: 'America' },
  { name: 'Mumbai', utc_difference: 5, continent: 'Asia' },
  { name: 'Nassau', utc_difference: -4, continent: 'America' },
  { name: 'New Delhi', utc_difference: 5, continent: 'Asia' },
  { name: 'New Orleans', utc_difference: -5, continent: 'America' },
  { name: 'Oslo', utc_difference: 2, continent: 'Europa' },
  { name: 'Ottawa', utc_difference: -4, continent: 'America' },
  { name: 'Rio de Janeiro', utc_difference: -3, continent: 'America' },
  { name: 'Salt Lake City', utc_difference: -6, continent: 'America' },
  { name: 'San Francisco', utc_difference: -8, continent: 'America' },
  { name: 'San Juan', utc_difference: -3, continent: 'America' },
  { name: 'San Salvador', utc_difference: -6, continent: 'America' },
  { name: 'Seattle', utc_difference: -7, continent: 'America' },
  { name: 'Seoul', utc_difference: 9, continent: 'Asia' },
  { name: 'Suva', utc_difference: 12, continent: 'Oceania' },
  { name: 'Tegucigalpa', utc_difference: -6, continent: 'America' },
  { name: 'Toronto', utc_difference: -5, continent: 'America' },
  { name: 'Vancouver', utc_difference: -7, continent: 'America' },
  { name: 'Washington DC', utc_difference: -4, continent: 'America' },
  { name: 'Winnipeg', utc_difference: -5, continent: 'America' },
  { name: 'Yangon', utc_difference: 6, continent: 'Asia' }
]

timezones.each do |timezone|
  timezone = Timezone.find_or_create_by!(
    name: timezone[:name],
    utc_difference: timezone[:utc_difference].to_s,
    continent: timezone[:continent]
  )

  if timezone.save
    puts " [ ✅ ] #{timezone.name}"
  else
    puts " [ 🔴 ] #{timezone[:name]}"
  end
end

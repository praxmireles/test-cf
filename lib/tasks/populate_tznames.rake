namespace :db do
  namespace :seed do
    desc 'Populate time zone names'
    task populate_tznames: :environment do
      Timezone.find_each do |t|
        t.zone_name = "#{t.continent}/#{t.name}".tr(' ', '_')

        case t.name
        when 'GMT+12'
          t.zone_name = 'Etc/GMT+12'
        when 'Pago Pago'
          t.zone_name = "#{t.continent}/Pago_Pago"
        when 'Los Angeles', 'San Francisco', 'Las Vegas', 'Seattle'
          t.zone_name = "#{t.continent}/Los_Angeles"
        when 'Mexico City'
          t.zone_name = "#{t.continent}/Mexico_City"
        when 'Guatemala'
          t.zone_name = "#{t.continent}/Managua"
        when 'Calgary', 'Salt Lake City'
          t.zone_name = "#{t.continent}/Denver"
        when 'San Salvador'
          t.zone_name = "#{t.continent}/El_Salvador"
        when 'Dallas', 'Minneapolis', 'New Orleans', 'Winnipeg'
          t.zone_name = "#{t.continent}/Chicago"
        when 'New York', 'Boston', 'Washington DC', 'Miami', 'Ottawa', 'Atlanta', 'Kingston'
          t.zone_name = "#{t.continent}/New_York"
        when 'Indianapolis, Indiana'
          t.zone_name = "#{t.continent}/Indiana/Indianapolis"
        when 'La Paz'
          t.zone_name = "#{t.continent}/La_Paz"
        when 'Puerto Rico'
          t.zone_name = "#{t.continent}/Puerto_Rico"
        when 'St Johns'
          t.zone_name = "#{t.continent}/St_Johns"
        when 'Habana'
          t.zone_name = 'Cuba'
        when 'Sao Paulo'
          t.zone_name = "#{t.continent}/Sao_Paulo"
        when 'Brasilia'
          t.zone_name = 'Brazil/East'
        when 'Buenos Aires, Argentina'
          t.zone_name = 'America/Argentina/Buenos_Aires'
        when 'San Juan'
          t.zone_name = 'America/Argentina/San_Juan'
        when 'Rio de Janeiro'
          t.zone_name = 'Brazil/East'
        when 'South Georgia'
          t.zone_name = "#{t.continent}/South_Georgia"
        when 'Cape Verde'
          t.zone_name = "#{t.continent}/Cape_Verde"
        when 'Cape Towm'
          t.zone_name = 'Africa/Johannesburg'
        when 'Frankfurt'
          t.zone_name = 'Europe/Berlin'
        when 'Addis Ababa'
          t.zone_name = "#{t.continent}/Addis_Ababa"
        when 'Ankara'
          t.zone_name = 'Turkey'
        when 'Antananarivo'
          t.zone_name = 'Indian/Antananarivo'
        when 'Doha'
          t.zone_name = 'Asia/Qatar'
        when 'Lahore', 'Islamabad'
          t.zone_name = 'Asia/Karachi'
        when 'New Delhi', 'Bangalore', 'Mumbai'
          t.zone_name = 'Asia/Kolkata'
        when 'Yangon'
          t.zone_name = 'Etc/GMT+6'
        when 'Hanoi'
          t.zone_name = "#{t.continent}/Bangkok"
        when 'Kuala Lumpur'
          t.zone_name = "#{t.continent}/Kuala_Lumpur"
        when 'Hong Kong'
          t.zone_name = "#{t.continent}/Hong_Kong"
        when 'Port Moresby'
          t.zone_name = "#{t.continent}/Port_Moresby"
        when 'Suva'
          t.zone_name = 'Pacific/Fiji'
        end

        t.save!
      end
    end
  end
end

# frozen_string_literal: true

module Timeable
  extend ActiveSupport::Concern
  DAYS_OF_WEEK = %w[
    Monday Tuesday Wednesday Thursday Friday Saturday Sunday
  ].freeze

  included do
    def next_7_days
      self.class.next_7_days
    end

    def day_of_week
      self.class.day_of_week
    end

    def week_days
      self.class.week_days
    end

    def closest_next_time(array_of_time, time)
      self.class.closest_next_time(array_of_time, time)
    end

    def base_times(parameters = {})
      self.class.base_times(parameters)
    end

    def self.next_7_days
      (Date.today...7.days.from_now).map { |x| x.strftime('%d/%m/%Y') }
    end

    # Current day of the week
    #
    # Returns [String]
    #
    #  e.g: "Monday"
    def self.day_of_week
      Time.now.strftime('%A')
    end

    def self.week_days
      DAYS_OF_WEEK.map
    end

    # Closest future time from an array of time
    #
    # Params:
    # - array_of_time [Array]: List of times to compare the time param with it.
    # - time [String]: A string of time (24h clock).
    #
    # Returns [String]
    #  closest_next_time(['09:00', '4:30'], '4:5')
    #  => "4:30"
    def self.closest_next_time(array_of_time, time)
      if array_of_time.index(time)
        time
      else
        comparison_array = array_of_time.dup
        comparison_array << time
        comparison_array = comparison_array.sort_by do |x|
          [x.split(':')[0].to_i, x.split(':')[1].to_i]
        end
        if time == comparison_array[-1]
          nil
        else
          array_of_time[comparison_array.index(time)]
        end
      end
    end

    # Array of time from start_time to end_time
    #
    # Params:
    # - start_time [Datetme]: time in hours
    # - end_time [DateTime]: time in hours
    # - increment [DateTime]: time in minutes
    # - meridian [boolean]: set to true if you want to return to return AM/PM
    #
    # Returns [Array]
    # base_hours(start_time: 8.hours, end_time: 23.hours, increment: 30.minutes)
    def self.base_times(parameters = {})
      start_time = parameters[:start_time] || 8
      end_time = parameters[:end_time] || 24.hours
      increment = parameters[:increment] || 30.minutes
      Array.new(1 + (end_time - start_time) / increment) do |i|
        time = (Time.now.midnight + (i * increment) + start_time)

        if parameters[:meridian] == true
          time.strftime('%I:%M %p')
        else
          time.strftime('%H:%M')
        end
      end
    end

    def self.calculate_end_date_from_duration(start_date, duration_in_min); end

    def self.duration_in_min_betwen_times(time1, time2); end
  end
end

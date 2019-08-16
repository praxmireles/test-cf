require 'opentok'

Opentok = OpenTok::OpenTok.new '46259142', 'ac9d58237ca34b14565c1ebbbcdbc8d748de91c9' if Rails.env.test?
Opentok = OpenTok::OpenTok.new ENV['OPENTOK_API_KEY'], ENV['OPENTOK_SECRET_KEY'] unless Rails.env.test?

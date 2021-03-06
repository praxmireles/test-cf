# frozen_string_literal: true

# == Schema Information
#
# Table name: admins
#
#  id         :bigint(8)        not null, primary key
#  type       :string
#  first_name :string
#  last_name  :string
#  email      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Interviewer < AdminUser
end

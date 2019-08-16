# frozen_string_literal: true

# == Schema Information
#
# Table name: appointment_packs
#
#  id          :bigint(8)        not null, primary key
#  user_id     :bigint(8)
#  type        :string           default("OpenAppointmentPack")
#  expert_id   :integer
#  price       :float
#  description :text
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  service_id  :bigint(8)
#

class InProgressAppointmentPack < AppointmentPack
end

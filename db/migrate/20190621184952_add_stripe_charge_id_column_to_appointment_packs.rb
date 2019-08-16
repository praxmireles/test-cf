class AddStripeChargeIdColumnToAppointmentPacks < ActiveRecord::Migration[5.2]
  def change
    add_column :appointment_packs, :stripe_charge_id, :string
  end
end

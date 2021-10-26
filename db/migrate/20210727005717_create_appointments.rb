class CreateAppointments < ActiveRecord::Migration[6.1]
  def change
    create_table :appointments do |t|

      t.timestamps

      t.references :doctor, index: true
      t.references :patient, index: true
    end
  end
end

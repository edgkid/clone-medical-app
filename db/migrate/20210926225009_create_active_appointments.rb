class CreateActiveAppointments < ActiveRecord::Migration[6.1]
  def change
    create_table :active_appointments do |t|

      t.string :status
  
      t.timestamps 

      t.references :appointment, index: true
      t.references :patient_plan, index: true

    end
  end
end

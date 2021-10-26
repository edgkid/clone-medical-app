class CreateAppointmentLogs < ActiveRecord::Migration[6.1]
  def change
    create_table :appointment_logs do |t|

      t.string :status
      t.integer :patient_id
      t.integer :doctor_id
      t.integer :patient_plan_id
      t.timestamps
      
    end
  end
end

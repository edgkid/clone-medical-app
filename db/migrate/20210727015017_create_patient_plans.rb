class CreatePatientPlans < ActiveRecord::Migration[6.1]
  def change
    create_table :patient_plans do |t|

      t.string :payment_type
      t.string :reference_number
      t.string :status
      t.date :payment_date

      t.timestamps

      t.references :patient, index: true
      t.references :plan, index: true
      t.references :bank, index: true

    end
  end
end

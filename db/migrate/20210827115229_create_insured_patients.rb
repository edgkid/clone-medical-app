class CreateInsuredPatients < ActiveRecord::Migration[6.1]
  def change
    create_table :insured_patients do |t|

      t.string :status
      t.string :code

      t.timestamps

      t.references :insurance, index: true
      t.references :patient, index: true
      t.references :plan, index: true
      t.references :company, index: true

    end
  end
end

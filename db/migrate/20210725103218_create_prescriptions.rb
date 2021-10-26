class CreatePrescriptions < ActiveRecord::Migration[6.1]
  def change
    create_table :prescriptions do |t|

      t.string :medicine
      t.text :use
      
      t.timestamps

      t.references :appointment, index: true
    end
  end
end

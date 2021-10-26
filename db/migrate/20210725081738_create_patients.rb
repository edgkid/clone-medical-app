class CreatePatients < ActiveRecord::Migration[6.1]
  def change
    create_table :patients do |t|
      t.string :name
      t.string :middle_name
      t.string :last_name
      t.string :surname
      t.string :document
      t.string :phone
      t.string :gender
      t.string :marital_status
      t.string :mail
      t.date :birthday
      t.string :status
      t.text :address

      t.timestamps

      t.references :user, index: true
    end
  end
end

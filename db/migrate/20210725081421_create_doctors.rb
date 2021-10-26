class CreateDoctors < ActiveRecord::Migration[6.1]
  def change
    create_table :doctors do |t|
      t.string :name
      t.string :middle_name
      t.string :last_name
      t.string :surname
      t.string :document
      t.string :phone
      t.string :gender
      t.string :mail
      t.date :birthday
      t.string :specialty
      t.string :status
      t.text :address

      t.timestamps

      t.references :area, index: true
      t.references :user, index: true

      t.text :firm
     
    end
  end
end

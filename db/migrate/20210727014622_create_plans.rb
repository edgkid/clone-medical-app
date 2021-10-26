class CreatePlans < ActiveRecord::Migration[6.1]
  def change
    create_table :plans do |t|

      t.string :name
      t.string :description
      t.float :cost
      t.integer :total_appointments
      t.string :status
      t.string :image

      t.timestamps
    end
  end
end

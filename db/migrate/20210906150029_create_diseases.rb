class CreateDiseases < ActiveRecord::Migration[6.1]
  def change
    create_table :diseases do |t|

      t.string :diagnostic_code
      t.string :diagnostic_des
      t.timestamps
    end
  end
end

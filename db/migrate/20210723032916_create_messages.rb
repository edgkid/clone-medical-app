class CreateMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :messages do |t|
      t.text :content

      t.timestamps

      t.references :appointment, index: true
    end
  end
end

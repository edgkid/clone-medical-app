class AddStatusToAreas < ActiveRecord::Migration[6.1]
  def change
    add_column :areas, :status, :string
  end
end

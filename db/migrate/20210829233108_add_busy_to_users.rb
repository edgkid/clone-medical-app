class AddBusyToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :busy, :string
  end
end

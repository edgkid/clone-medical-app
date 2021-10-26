class AddUserToMessage < ActiveRecord::Migration[6.1]
  def change
    add_column :messages, :user, :string
  end
end

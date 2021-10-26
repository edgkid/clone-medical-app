class AddStatusFileToDoctor < ActiveRecord::Migration[6.1]
  def change
    add_column :doctors, :status_file, :string
  end
end

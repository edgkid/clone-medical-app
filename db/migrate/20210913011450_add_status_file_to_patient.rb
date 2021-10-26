class AddStatusFileToPatient < ActiveRecord::Migration[6.1]
  def change
    add_column :patients, :status_file, :string
  end
end

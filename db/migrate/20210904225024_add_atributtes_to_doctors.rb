class AddAtributtesToDoctors < ActiveRecord::Migration[6.1]
  def change
    add_column :doctors, :ficha, :string
    add_column :doctors, :rif, :string
    add_column :doctors, :sanidad, :string
    add_column :doctors, :code_doctor, :string
  end
end

class AddCaseToAppointments < ActiveRecord::Migration[6.1]
  def change
    add_column :appointments, :case_number, :integer
  end
end

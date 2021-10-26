class AddPatientDoctorToMessage < ActiveRecord::Migration[6.1]
  def change
    add_reference :messages, :user, null: false, foreign_key: true
    remove_column :messages, :user
  end
end

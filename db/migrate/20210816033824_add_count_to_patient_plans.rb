class AddCountToPatientPlans < ActiveRecord::Migration[6.1]
  def change
    add_column :patient_plans, :count, :integer
  end
end

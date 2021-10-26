class AddTypeToPatientPlans < ActiveRecord::Migration[6.1]
  def change
    add_column :patient_plans, :type_plan, :string
  end
end

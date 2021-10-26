class AddCountToMedicalPlans < ActiveRecord::Migration[6.1]
  def change

    add_column :medical_plans, :count, :integer
    
  end
end

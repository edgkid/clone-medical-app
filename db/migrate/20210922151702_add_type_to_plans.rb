class AddTypeToPlans < ActiveRecord::Migration[6.1]
  def change
    add_column :plans, :type_plan, :string
  end
end

class AddCodeToPlan < ActiveRecord::Migration[6.1]
  def change
    add_column :plans, :code, :string
  end
end

class AddStatusToBanks < ActiveRecord::Migration[6.1]
  def change
    add_column :banks, :status, :string
  end
end

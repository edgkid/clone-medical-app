class AddStatusToPasswordRequests < ActiveRecord::Migration[6.1]
  def change
    add_column :password_requests, :status, :string
  end
end

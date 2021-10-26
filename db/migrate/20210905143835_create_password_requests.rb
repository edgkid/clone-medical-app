class CreatePasswordRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :password_requests do |t|
      t.string :user_name
      t.timestamps
    end
  end
end

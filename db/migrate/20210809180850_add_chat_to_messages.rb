class AddChatToMessages < ActiveRecord::Migration[6.1]
  def change
    add_reference :messages, :chat, null: true, foreign_key: true
    remove_column :messages, :appointment_id
  end
end

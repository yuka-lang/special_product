class AddSenderToChat < ActiveRecord::Migration[5.2]
  def change
    add_column :chats, :sender, :integer
  end
end

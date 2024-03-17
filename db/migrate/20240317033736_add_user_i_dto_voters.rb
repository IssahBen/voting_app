class AddUserIDtoVoters < ActiveRecord::Migration[7.1]
  def change
    add_column :voters, :user_id, :int
  end
end

class AddUserIdToCandidates < ActiveRecord::Migration[7.1]
  def change
    add_column :candidates, :user_id, :int
  end

end

class Removevoterid < ActiveRecord::Migration[7.1]
  def change
    remove_column :voters, :voter_id
  end
end

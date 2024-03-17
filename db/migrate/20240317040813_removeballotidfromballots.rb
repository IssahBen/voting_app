class Removeballotidfromballots < ActiveRecord::Migration[7.1]
  def change
    remove_column :ballots, :ballot_id
  end
end

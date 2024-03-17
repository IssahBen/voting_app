class CreateBallotVoters < ActiveRecord::Migration[7.1]
  def change
    create_table :ballot_voters do |t|
      t.integer :ballot_id
      t.integer :voter_id

      t.timestamps
    end
  end
end

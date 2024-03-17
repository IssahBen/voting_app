class CreateVoters < ActiveRecord::Migration[7.1]
  def change
    create_table :voters do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.timestamps
    end
  end
end

# frozen_string_literal: true

class AddUserIdToBallot < ActiveRecord::Migration[7.1]
  def change
    add_column :ballots, :user_id, :int
  end
end

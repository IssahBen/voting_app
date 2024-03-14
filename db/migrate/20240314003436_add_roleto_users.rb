# frozen_string_literal: true

class AddRoletoUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :role, :string, default: 'Voter'
  end
end

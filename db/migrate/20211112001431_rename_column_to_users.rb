# frozen_string_literal: true

class RenameColumnToUsers < ActiveRecord::Migration[6.1]
  def up
    remove_column :users, :role, :string
    add_column :users, :admin, :boolean
  end

  def down
    remove_column :users, :admin, :boolean
    add_column :users, :role, :string
  end
end

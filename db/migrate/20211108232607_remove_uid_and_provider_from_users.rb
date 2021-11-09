# frozen_string_literal: true

class RemoveUidAndProviderFromUsers < ActiveRecord::Migration[6.1]
  def change
    change_column_null(:users, :uid, true)
    change_column_null(:users, :provider, true)
  end
end

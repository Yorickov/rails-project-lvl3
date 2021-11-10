# frozen_string_literal: true

class AddNullConstrainToDesciptionToBulletin < ActiveRecord::Migration[6.1]
  def change
    change_column_null :bulletins, :description, false
  end
end

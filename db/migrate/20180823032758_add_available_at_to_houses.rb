# frozen_string_literal: true

class AddAvailableAtToHouses < ActiveRecord::Migration[5.2]
  def change
    add_column :houses, :available_at, :date, null: false
  end
end

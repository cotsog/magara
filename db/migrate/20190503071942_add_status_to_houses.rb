# frozen_string_literal: true

class AddStatusToHouses < ActiveRecord::Migration[5.2]
  def change
    add_column :houses, :status, :integer, default: 0
  end
end

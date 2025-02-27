# frozen_string_literal: true

class AddUserRefToHouses < ActiveRecord::Migration[5.2]
  def change
    add_reference :houses, :user, foreign_key: true
  end
end

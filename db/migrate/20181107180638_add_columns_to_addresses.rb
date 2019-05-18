# frozen_string_literal: true

class AddColumnsToAddresses < ActiveRecord::Migration[5.2]
  def change
    add_column :addresses, :latitude,  :float
    add_column :addresses, :longitude, :float

    add_index :addresses, %i[latitude longitude]
  end
end

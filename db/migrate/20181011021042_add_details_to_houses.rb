class AddDetailsToHouses < ActiveRecord::Migration[5.2]
  def change
    add_column :houses, :lease_length, :int
    add_column :houses, :built_in,     :date
  end
end

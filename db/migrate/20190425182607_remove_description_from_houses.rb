class RemoveDescriptionFromHouses < ActiveRecord::Migration[6.0]
  def change
    remove_column :houses, :description, :text
  end
end

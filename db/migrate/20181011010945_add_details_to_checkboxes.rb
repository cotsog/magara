class AddDetailsToCheckboxes < ActiveRecord::Migration[5.2]
  def change
    add_column :checkboxes, :washer, :boolean
    add_column :checkboxes, :dryer,  :boolean
  end
end

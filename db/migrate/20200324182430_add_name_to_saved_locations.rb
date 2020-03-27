class AddNameToSavedLocations < ActiveRecord::Migration[5.0]
  def change
    add_column :saved_locations, :name, :string
  end
end

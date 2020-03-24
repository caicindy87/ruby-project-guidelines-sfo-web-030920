class CreateSavedLocations < ActiveRecord::Migration[5.0]
  def change
    create_table :saved_locations do |t|
      t.integer  :user_id  
      t.integer  :place_id 
    end
  end
end
# create_table :places do |t|
#   t.string :name
#   t.string :address
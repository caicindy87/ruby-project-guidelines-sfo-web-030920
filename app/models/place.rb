class Place < ActiveRecord::Base
    
      has_many :saved_locations
      has_many :users, through: :saved_locations

end
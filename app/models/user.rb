class User < ActiveRecord::Base
    
    has_many :saved_locations
    has_many :places, through: :saved_locations

end
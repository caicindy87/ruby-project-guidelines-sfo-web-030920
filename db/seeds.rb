
User.delete_all
Place.delete_all
SavedLocation.delete_all

user = User.create( name: "Mike", user_location: "1460 Mission St, San Francisco, CA 94103")
place = Place.create( address: "12 10th St, San Francisco, CA 94103", name: "SimplexiTea ")

s_location = SavedLocation.create( name: "SimplexiTea ") 
                                
# s_location.user = user

# user.saved_locations << s_location

# place.saved_locations << s_location


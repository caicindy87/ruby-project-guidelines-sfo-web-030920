
User.delete_all
Place.delete_all
SavedLocation.delete_all

# user = User.create( name: "Mike", user_location: "1460 Mission St, San Francisco, CA 94103")
# place = Place.create( address: "12 10th St, San Francisco, CA 94103", name: "SimplexiTea ")

# s_location = SavedLocation.create( user: user, place: place, name: "SimplexiTea " ) 
                                


# can use this to seed database 
# get_businesses_from_yelp_api.each do |business|
#     Place.create(name: business["name"], address: business["location"]["display_address"][0] + business["location"]["display_address"][1])
# end
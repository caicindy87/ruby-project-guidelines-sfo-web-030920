
user  = User.create( name: "Mike",user_location: "1460 Mission St, San Francisco, CA 94103")

place = Place.create( address: "12 10th St, San Francisco, CA 94103", name: "SimplexiTea ")

s_location = SavedLocation.create( name: )
                                #  name: ,place:
#     create_table "places", force: :cascade do |t|
#       t.string "name"
#       t.string "address"
#     end
  
#     create_table "saved_locations", force: :cascade do |t|
#       t.integer "user_id"
#       t.integer "place_id"
#     end
  
#     create_table "users", force: :cascade do |t|
#       t.string "name"
#       t.string "user_location"
#     end
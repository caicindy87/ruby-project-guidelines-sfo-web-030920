require_relative '../config/environment'



#puts "HELLO WORLD"


hello
user_name = get_user_name
user_location = get_user_location
user = create_user(user_name, user_location) # user = an object of User
start_search(user_location, user)

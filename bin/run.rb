require_relative '../config/environment'



#puts "HELLO WORLD"


# calls functions that are written in command-line-interface file

hello
user_name = get_user_name
user_location = get_user_location
create_user(user_name, user_location)

start_search
want_to_save?
response = get_response_to_save_or_not
create_place_record(response)
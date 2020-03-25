# what user sees and will interact with


def hello
    puts 'Hello!'
    puts 'Please enter your name and current address (full address)'
end

def get_user_name
    user_name = gets.chomp
end

def get_user_location
    user_location = gets.chomp
end

def create_user(name, user_location)
    User.create(name: name, user_location: user_location)
end

def view_user_location
end

def change_user_location
end

def start_search
    puts 'enter 1 to find 5 random places'
    user_input = gets.chomp # user input is string data type
    if user_input.to_i == 1 # can change user input to integer
        display_five_place_names
    else
        puts "bye"
    end
end

# if the response is not what we want, how do we prevent next methods from running? - need to add custom error
def want_to_save?
    puts "press 1 to save option 1"
    puts "press 2 to save option 2"
    puts "press 3 to save option 3"
    puts "press 4 to save option 4"
    puts "press 5 to save option 5"
    puts "press 0 to see next five results"
end

def get_response_to_save_or_not
    response = gets.chomp.to_i
end

# create 1 new Place instance / object
# get_businesses_from_yelp_api returns an array of hashes
def create_place_obj
    option_one = get_businesses_from_yelp_api[0]
    Place.create(name: option_one["name"], address: "#{option_one["location"]["display_address"][0]}, #{option_one["location"]["display_address"][1]}")
end






# when user wants to save location, that is when you create new instance of place and saved_location


# what if they want to save multiple locations?


# def display_saved_locations
# end










    

# if user_input.to_i == 1 # can change user input to integer
#     puts options[0]
# elsif user_input.to_i == 2        
#     puts options[1]
# elsif user_input.to_i == 3
#     puts options[2]
# elsif user_input.to_i == 4
#     puts options[3]
# elsif user_input.to_i == 5
#     puts options[4]
# else
#     puts "That's not a correct input number."
# end
# end
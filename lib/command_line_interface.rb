# what user sees and will interact with


def hello
    puts 'Hello!'
end

def get_user_name
    puts 'Please enter your name first'
    user_name = gets.chomp
end

def get_user_location
    puts 'Next, please enter current address'
    user_location = gets.chomp
end

def create_user(name, user_location)
    User.create(name: name, user_location: user_location)
end

def view_user_location(name) # find user's current location by entering user's name (name == string)
    User.find_by(name: name)
end


def change_user_location(name, new_user_address)
   if User.find_by(name: name)
        user = User.find_by(name: name)
        user.user_location = new_user_address
        user.save
        return user.user_location
    end
end


def delete_user(name)
    User.find_by(name: name).destroy
end


def start_search
    puts 'Enter go to find five random places.'
    user_input = gets.chomp # user input is string data type
    if user_input ==  "go"                                  # can change user input to integer using .to_i
        display_five_place_names
    else
        # puts "I do not recognize that command. I said enter 'go.' "
        puts "I said enter 'go.' I'm sorry I thought you could read... "
        # if the response is not what we want, how do we prevent next methods from running? - need to add custom error
    end
end


def want_to_save?
    puts "enter 'one' to save option 1"
    puts "enter 'two' to save option 2"
    puts "enter 'three' to save option 3"
    puts "enter 'four' to save option 4"
    puts "enter 'five' to save option 5"
    puts "enter 'next' to see next five results"
end

def get_response_to_save_or_not
    response = gets.chomp
end


# create 1 new Place instance / object
# get_businesses_from_yelp_api returns an array of hashes
def create_place_record(response)
    if response == 'one'
        option_one = get_businesses_from_yelp_api[0]
        Place.create(name: option_one["name"], address: "#{option_one["location"]["display_address"][0]}, #{option_one["location"]["display_address"][1]}")
    elsif response == 'two'
        option_two = get_businesses_from_yelp_api[1]
        Place.create(name: option_two["name"], address: "#{option_two["location"]["display_address"][0]}, #{option_two["location"]["display_address"][1]}")
    elsif response == 'three'
        option_three = get_businesses_from_yelp_api[2]
        Place.create(name: option_three["name"], address: "#{option_three["location"]["display_address"][0]}, #{option_three["location"]["display_address"][1]}")
    elsif response == 'four'
        option_four = get_businesses_from_yelp_api[3]
        Place.create(name: option_four["name"], address: "#{option_four["location"]["display_address"][0]}, #{option_four["location"]["display_address"][1]}")
    elsif response == 'five'
        option_five = get_businesses_from_yelp_api[4]
        Place.create(name: option_five["name"], address: "#{option_five["location"]["display_address"][0]}, #{option_five["location"]["display_address"][1]}")
    end
end

def create_saved_location_record
    
    SavedLocation(user: , place: , name:)
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
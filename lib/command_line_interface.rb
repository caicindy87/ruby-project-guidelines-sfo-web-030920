# what user sees and will interact with


def hello
    puts 'Hello!'
end

def get_user_name  # saves user's name in string form
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

def view_user_info(name) # find user and view user's name and current location by entering user's name (name == string)
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

def save_option_one
    option_one = get_businesses_from_yelp_api[0]
    current_user_obj = User.all.last
        place_one = Place.create(name: option_one["name"], address: "#{option_one["location"]["display_address"][0]}, #{option_one["location"]["display_address"][1]}")
        saved_location_one = SavedLocation.create(user: current_user_obj, place: place_one, name: option_one["name"])
        saved_location_one
end
def save_option_two
    option_two = get_businesses_from_yelp_api[1]
        place_two = Place.create(name: option_two["name"], address: "#{option_two["location"]["display_address"][0]}, #{option_two["location"]["display_address"][1]}")
        saved_location_two = SavedLocation.create(user: current_user_obj, place: place_two, name: option_two["name"])
        saved_location_two
end
def save_option_three
    option_three = get_businesses_from_yelp_api[2]
    place_three = Place.create(name: option_three["name"], address: "#{option_three["location"]["display_address"][0]}, #{option_three["location"]["display_address"][1]}")
    saved_location_three = SavedLocation.create(user: current_user_obj, place: place_three, name: option_three["name"])
    saved_location_three
end
def save_option_four
    option_four = get_businesses_from_yelp_api[3]
    place_four = Place.create(name: option_four["name"], address: "#{option_four["location"]["display_address"][0]}, #{option_four["location"]["display_address"][1]}")
    saved_location_four = SavedLocation.create(user: current_user_obj, place: place_four, name: option_four["name"])
    saved_location_four
end
def save_option_five
    option_five = get_businesses_from_yelp_api[4]
    place_five = Place.create(name: option_five["name"], address: "#{option_five["location"]["display_address"][0]}, #{option_five["location"]["display_address"][1]}")
    saved_location_five = SavedLocation.create(user: current_user_obj, place: place_five, name: option_five["name"])
    saved_location_five
end

def create_place_record(response)
    if response == 'one'
        save_option_one
    elsif response == 'two'
        save_option_two
    elsif response == 'three'
        save_option_three
    elsif response == 'four'
        save_option_four
    elsif response == 'five'
        save_option_five
    end
end









# def create_saved_location_record
#     current_user = view_user_info   # view_user_info returns current user record which is saved to variable called current_user
#     place_to_save = 
#     SavedLocation(user: current_user.name, place: , name:)
# end






# when user wants to save location, that is when you create new instance of place and saved_location


# what if they want to save multiple locations?


# def display_saved_locations
# end







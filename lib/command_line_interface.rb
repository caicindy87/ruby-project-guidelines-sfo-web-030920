# what user sees and will interact with


def hello
    puts 'Hello!'
end

# check by user_id to see if they have account
def get_user_name  # saves user's name in string form
    puts 'Please enter your name first'
    user_name = gets.chomp
end

def get_user_location # defining method
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

def get_20_businesses(user_location) # array of 20 business names
    return get_businesses_from_yelp_api(user_location).map do |business|
       {name: business["name"], address: "#{business["location"]["display_address"][0]}, #{business["location"]["display_address"][1]}"}
    end
end

# def get_20_businesses_address(user_location) # array of 20 business addresses
#     return get_businesses_from_yelp_api(user_location).map do |business|
#         "#{business["location"]["display_address"][0]}, #{business["location"]["display_address"][1]}"
#     end
# end

def display_five_place_names(businesses, count=0)
    for i in count...(count + 5)
        puts businesses[i][:name]
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

def start_search(user_location, user)
    puts 'Enter go to find five random places.'
    user_input = gets.chomp # user input is string data type
    if user_input ==  "go" 
        businesses = get_20_businesses(user_location)  # businesses = array of 20 hashes, each hash has busi name and address
        puts display_five_place_names(businesses, 0)
        want_to_save?
        get_response_to_save_or_not(businesses, 5, user)

        # want_to_save?
        # get_response_to_save_or_not(businesses, 10, user)
        # want_to_save?
        # get_response_to_save_or_not(businesses, 15, user)
    else
        puts "I said enter 'go.' I'm sorry I thought you could read... "
        # if the response is not what we want, how do we prevent next methods from running? - just call method again
        start_search(user_location)
    end
end

def get_response_to_save_or_not(businesses, count, user)
    response = gets.chomp
    if response == 'one'
        save_option_one(businesses, user)
        # after saving location, user can see next five locations, change their current location, or view saved locations
        puts 'To see more locations, enter next'
        puts 'To change your current location, enter change'
        puts 'To view your saved locations, enter saved'
    elsif response == 'two'
        save_option_two
    elsif response == 'three'
        save_option_three
    elsif response == 'four'
        save_option_four
    elsif response == 'five'
        save_option_five
    elsif response == 'next'
       puts display_five_place_names(businesses, count)
    end
end

# when user wants to save location, that is when you create new instance of place and saved_location
def save_option_one(businesses, user)
    first_business_name = businesses[0][:name]
    first_business_address = businesses[0][:address]
    place = Place.create(name: first_business_name, address: first_business_address)
    SavedLocation.create(user_id: user.id, place_id: place.id, name: first_business_name)
end

# def save_option_one
#     option_one = get_businesses_from_yelp_api[0]
#     current_user_obj = User.all.last
#         place_one = Place.create(name: option_one["name"], address: "#{option_one["location"]["display_address"][0]}, #{option_one["location"]["display_address"][1]}")
#         saved_location_one = SavedLocation.create(user: current_user_obj, place: place_one, name: option_one["name"])
#         saved_location_one
# end
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




def display_saved_locations # display user's saved locations
    User.all.last.saved_locations
end

def next_five_results
end

# what to do if there are no more results
# what if they want to save multiple locations?



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

def change_user_location(user, new_user_address)
    user.user_location = new_user_address
    user.save
    user.user_location
end

def get_new_user_location # defining method
    puts 'Please enter current address'
    user_location = gets.chomp
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

def display_five_place_names(businesses, num=0)
    for i in num...(num + 5)
        puts businesses[i][:name]
    end
end

def want_to_save?(count)
    puts "enter '#{count}' to save option #{count}"
    puts "enter '#{count + 1}' to save option #{count + 1}"
    puts "enter '#{count + 2}' to save option #{count + 2}"
    puts "enter '#{count + 3}' to save option #{count + 3}"
    puts "enter '#{count + 4}' to save option #{count + 4}"
    puts "enter 'next' to see next five results"
end

def start_search(user_location, user)
    puts 'Enter go to find five random places.'
    user_input = gets.chomp # user input is string data type
    if user_input ==  "go" 
        businesses = get_20_businesses(user_location)  # businesses = array of 20 hashes, each hash has busi name and address
        display_five_place_names(businesses, 0)
        want_to_save?(1)
        get_response_to_save_or_not(businesses, 1, 5, user)
    else
        puts "I said enter 'go.' I'm sorry I thought you could read... "
        # if the response is not what we want, how do we prevent next methods from running? - just call method again
        start_search(user_location, user)
    end
end

def get_response_to_save_or_not(businesses, count, num, user) # count is for the response. num is index to display business name
    response = gets.chomp
    if response == "#{count}"
        save_option(businesses, count, user)
        # after saving location, user can see next five locations, change their current location, or view saved locations
        options_after_saving(businesses, num, user)
    elsif response == "#{count + 1}"
        save_option(businesses, (count + 1), user)
        options_after_saving(businesses, num, user)
    elsif response == "#{count + 2}"
        save_option(businesses, (count + 2), user)
        options_after_saving(businesses, num, user)
    elsif response == "#{count + 3}"
        save_option(businesses, (count + 3), user)
        options_after_saving(businesses, num, user)
    elsif response == "#{count + 4}"
        save_option(businesses, (count + 4), user)
        options_after_saving(businesses, num, user)
    elsif response == 'next'
        if num == 15
            display_five_place_names(businesses, num)
            last_want_to_save?(num + 1)
            return last_get_response_to_save_or_not(businesses, num + 1, num + 5, user)
        end
            display_five_place_names(businesses, num)
            want_to_save?(num + 1)
            get_response_to_save_or_not(businesses, num + 1, num + 5, user)
    end
end

def options_after_saving(businesses, num, user)
    puts "To see more locations, enter 'next'"
    puts "To change your current location and start new search, enter 'change'"
    puts "To view your saved locations, enter 'saved'"
    response = gets.chomp
    if response == "next"
        if num == 15
            display_five_place_names(businesses, num)
            last_want_to_save?(num + 1)
            return last_get_response_to_save_or_not(businesses, num + 1, num + 5, user)
        end
        display_five_place_names(businesses, num) # display business names of 5-10
        want_to_save?(num + 1) # 6 - 10
        get_response_to_save_or_not(businesses, num + 1, num + 5, user)        
    elsif response == "change"
        new_user_address = get_new_user_location
        change_user_location(user, new_user_address)
        start_search(new_user_address, user)
    elsif response == "saved"
        display_saved_locations(user)
    end
end

def last_want_to_save?(count)
    puts "enter '#{count}' to save option #{count}"
    puts "enter '#{count + 1}' to save option #{count + 1}"
    puts "enter '#{count + 2}' to save option #{count + 2}"
    puts "enter '#{count + 3}' to save option #{count + 3}"
    puts "enter '#{count + 4}' to save option #{count + 4}"
    puts "These are all available options from this location"
    puts "To change your current location and start new search, enter 'change'"
    puts "To view your saved locations, enter 'saved'"
    puts "To exit app, enter 'exit'"
end

def last_get_response_to_save_or_not(businesses, count, num, user)
    response = gets.chomp
    if response == "#{count}"
        save_option(businesses, count, user)
        # after saving location, user can see next five locations, change their current location, or view saved locations
        last_options_after_saving(businesses, num, user)
    elsif response == "#{count + 1}"
        save_option(businesses, (count + 1), user)
        last_options_after_saving(businesses, num, user)
    elsif response == "#{count + 2}"
        save_option(businesses, (count + 2), user)
        last_options_after_saving(businesses, num, user)
    elsif response == "#{count + 3}"
        save_option(businesses, (count + 3), user)
        last_options_after_saving(businesses, num, user)
    elsif response == "#{count + 4}"
        save_option(businesses, (count + 4), user)
        last_options_after_saving(businesses, num, user)
    elsif response == "change"
        # change method
        new_user_address = get_new_user_location
        change_user_location(user, new_user_address)
        start_search(new_user_address, user)
    elsif response == "saved"
        display_saved_locations(user)
    elsif response == "exit"
        puts "Thank you for using our App, bye."
    end
end

def last_options_after_saving(businesses, num, user)
    puts "To change your current location and start new search, enter 'change'"
    puts "To view your saved locations, enter 'saved'"
    response = gets.chomp
    if response == "next"
        if num == 15
            display_five_place_names(businesses, num)
            last_want_to_save?(num + 1)
            return last_get_response_to_save_or_not(businesses, num + 1, num + 5, user)
        end
        display_five_place_names(businesses, num) # display business names of 5-10
        want_to_save?(num + 1) # 6 - 10
        get_response_to_save_or_not(businesses, num + 1, num + 5, user)        
    elsif response == "change"
        new_user_address = get_new_user_location
        change_user_location(user, new_user_address)
        start_search(new_user_address, user)
    elsif response == "saved"
        display_saved_locations(user)
    end
end

# when user wants to save location, that is when you create new instance of place and saved_location
def save_option(businesses, count, user)
    business_name = businesses[count - 1][:name]
    business_address = businesses[count -1][:address]
    place = Place.create(name: business_name, address: business_address)
    saved_location = SavedLocation.create(user_id: user.id, place_id: place.id, name: business_name)
end



def display_saved_locations(user) # display user's saved locations
    puts all_saved = user.saved_locations.map {|location| location.name}
end


# what to do if there are no more results
# what if they want to save multiple locations?

















# def save_option_one
#     option_one = get_businesses_from_yelp_api[0]
#     current_user_obj = User.all.last
#         place_one = Place.create(name: option_one["name"], address: "#{option_one["location"]["display_address"][0]}, #{option_one["location"]["display_address"][1]}")
#         saved_location_one = SavedLocation.create(user: current_user_obj, place: place_one, name: option_one["name"])
#         saved_location_one
# end
# def save_option_two
#     option_two = get_businesses_from_yelp_api[1]
#         place_two = Place.create(name: option_two["name"], address: "#{option_two["location"]["display_address"][0]}, #{option_two["location"]["display_address"][1]}")
#         saved_location_two = SavedLocation.create(user: current_user_obj, place: place_two, name: option_two["name"])
#         saved_location_two
# end
# def save_option_three
#     option_three = get_businesses_from_yelp_api[2]
#     place_three = Place.create(name: option_three["name"], address: "#{option_three["location"]["display_address"][0]}, #{option_three["location"]["display_address"][1]}")
#     saved_location_three = SavedLocation.create(user: current_user_obj, place: place_three, name: option_three["name"])
#     saved_location_three
# end
# def save_option_four
#     option_four = get_businesses_from_yelp_api[3]
#     place_four = Place.create(name: option_four["name"], address: "#{option_four["location"]["display_address"][0]}, #{option_four["location"]["display_address"][1]}")
#     saved_location_four = SavedLocation.create(user: current_user_obj, place: place_four, name: option_four["name"])
#     saved_location_four
# end
# def save_option_five
#     option_five = get_businesses_from_yelp_api[4]
#     place_five = Place.create(name: option_five["name"], address: "#{option_five["location"]["display_address"][0]}, #{option_five["location"]["display_address"][1]}")
#     saved_location_five = SavedLocation.create(user: current_user_obj, place: place_five, name: option_five["name"])
#     saved_location_five
# end

# def create_place_record(response)
#     if response == 'one'
#         save_option_one
#     elsif response == 'two'
#         save_option_two
#     elsif response == 'three'
#         save_option_three
#     elsif response == 'four'
#         save_option_four
#     elsif response == 'five'
#         save_option_five
#     end
# end
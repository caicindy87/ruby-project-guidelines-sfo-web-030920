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

def view_user_info(user) # find user and view user's name and current location by entering user's name (name == string)
    puts user.name
    puts user.user_location
end

def change_user_location(user, new_user_address)
    user.user_location = new_user_address
    user.save
    user.user_location
end

def get_new_user_location # defining method
    puts 'Please enter a new address'
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

def display_five_place_names(businesses, num=0)
    for i in num...(num + 5)
        puts businesses[i][:name]
    end
end

def want_to_save?(count)
    puts "Enter '#{count}' to save option #{count}"
    puts "Enter '#{count + 1}' to save option #{count + 1}"
    puts "Enter '#{count + 2}' to save option #{count + 2}"
    puts "Enter '#{count + 3}' to save option #{count + 3}"
    puts "Enter '#{count + 4}' to save option #{count + 4}"
    puts "Enter 'next' to see next five results"
    puts "Enter 'view profile' to see user profile"
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
    elsif response == "view profile"
        view_user_info(user)
        options_after_seeing_saved_locations(num, user)
    else
        puts "That won't do. These are your options: "
        want_to_save?(1)
        get_response_to_save_or_not(businesses, count, num, user)
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
        options_after_seeing_saved_locations(num, user)
    else
        puts "Omg you're amazing, but I said these are your options:"
        options_after_saving(businesses, num, user)
    end
end

def options_after_seeing_saved_locations(num, user)
    puts "To start new search with current location, enter 'search'"
    puts "To change your current location and start new search, enter 'change'"
    puts "To exit app, enter 'exit'"
    response = gets.chomp
    if response == "search"
        start_search(user.user_location, user)
    elsif response == "change"
        new_user_address = get_new_user_location
        change_user_location(user, new_user_address)
        start_search(new_user_address, user)
    elsif response == "exit"
        puts "Thank you for using our App, bye."
    else
        puts "sigh... I guess you really don't know how to read"
        puts "How did you manage to open the app?"
        options_after_seeing_saved_locations(num, user)
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
    else
        puts "That won't do. These are your options: "
        want_to_save?(1)
        last_get_response_to_save_or_not(businesses, count, num, user)
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
    else
        puts "sigh... I guess you really don't know how to read"
        puts "How did you manage to open the app?"
        last_options_after_saving(businesses, num, user)
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


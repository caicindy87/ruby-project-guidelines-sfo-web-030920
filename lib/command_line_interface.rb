# what user sees and will interact with

def hello
    puts 'Hello!'
end

def get_user_name  # saves user's name in string form
    puts "------------------------------------"
    puts 'Please enter your name:'
    puts "------------------------------------"
    user_name = gets.chomp
end

def get_user_location # defining method
    puts "------------------------------------"
    puts 'Next, please enter current address:'
    puts "------------------------------------"
    user_location = gets.chomp
end

def create_user(name, user_location)
    user = User.find_or_create_by(name: name)
    user.update(user_location: user_location)
    user
end

def view_user_info(user) # find user and view user's name and current location by entering user's name (name == string)
    puts "*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*"
    puts ""
    puts "Name: #{user.name}"
    puts "Location: #{user.user_location}"
    puts ""
    puts "*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*"
end

def change_user_location(user, new_user_address)
    user.user_location = new_user_address
    user.save
    user.user_location
end

def get_new_user_location # defining method
    puts "------------------------------------"
    puts 'Please enter a new address'
    puts "------------------------------------"
    user_location = gets.chomp
end

def delete_user(user)
    user.destroy
end

def get_20_businesses(user_location) # array of 20 business names
    return get_businesses_from_yelp_api(user_location).map do |business|
       {name: business["name"], address: "#{business["location"]["display_address"][0]}, #{business["location"]["display_address"][1]}"}
    end
end

def display_five_place_names(businesses, num=0)
    for i in num...(num + 5)
        puts "#{i + 1} - #{businesses[i][:name]}"
    end
end

def want_to_save?(count)
    puts "------------------------------------"
    puts "Enter '#{count}' to save option #{count}"
    puts "Enter '#{count + 1}' to save option #{count + 1}"
    puts "Enter '#{count + 2}' to save option #{count + 2}"
    puts "Enter '#{count + 3}' to save option #{count + 3}"
    puts "Enter '#{count + 4}' to save option #{count + 4}"
    puts "Enter 'Next' to see next five results"
    puts "Enter 'View Profile' to see user profile"
    puts "Enter 'Saved' to view your saved locations"
    puts "------------------------------------"
end

def start_search(user_location, user)
    puts "------------------------------------"
    puts "Enter 'Go' to find five random places."
    puts "Enter 'View Profile' to see user profile"
    puts "Enter 'Saved' to view your saved locations"
    puts "------------------------------------"
    response = gets.chomp # user input is string data type
    if response == "go" || response == "Go" || response == "GO"
        businesses = get_20_businesses(user_location)  # businesses = array of 20 hashes, each hash has busi name and address
        display_five_place_names(businesses, 0)
        want_to_save?(1)
        get_response_to_save_or_not(businesses, 1, 5, user)
    elsif response == "view profile" || response == "View Profile" || response == "VIEW PROFILE"
        view_user_info(user)
        options_to_start_new_search(user)
    elsif response == "saved" || response == "Saved" || response == "SAVED"
        display_saved_locations(user)
        start_search(user_location, user)
    else
        puts "------------------------------------"
        puts "I said enter 'Go.' I'm sorry I thought you could read... "
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
    elsif response == "next" || response == "Next" || response == "NEXT"
        if num == 15
            display_five_place_names(businesses, num)
            last_want_to_save?(num + 1)
            return last_get_response_to_save_or_not(businesses, num + 1, num + 5, user)
        end
            display_five_place_names(businesses, num)
            want_to_save?(num + 1)
            get_response_to_save_or_not(businesses, num + 1, num + 5, user)
    elsif response == "view profile" || response == "View Profile" || response == "VIEW PROFILE"
        view_user_info(user)
        options_to_start_new_search(user)
    elsif response == "saved" || response == "Saved" || response == "SAVED"
        display_saved_locations(user)
        options_to_start_new_search(user)
    else
        puts "------------------------------------"
        puts "That won't do. These are your options: "
        want_to_save?(1)
        get_response_to_save_or_not(businesses, count, num, user)
    end
end


def options_after_saving(businesses, num, user)
    puts "------------------------------------"
    puts "To see more locations, enter 'Next'"
    puts "To change your current location and start new search, enter 'Change'"
    puts "To view your saved locations, enter 'Saved'"
    puts "------------------------------------"
    response = gets.chomp
    if response == "next" || response == "Next" || response == "NEXT"
        if num == 15
            display_five_place_names(businesses, num)
            last_want_to_save?(num + 1)
            return last_get_response_to_save_or_not(businesses, num + 1, num + 5, user)
        end
        display_five_place_names(businesses, num) # display business names of 5-10
        want_to_save?(num + 1) # 6 - 10
        get_response_to_save_or_not(businesses, num + 1, num + 5, user)        
    elsif response == "change" || response == "Change" || response == "CHANGE"
        new_user_address = get_new_user_location
        change_user_location(user, new_user_address)
        start_search(new_user_address, user)
    elsif response == "saved" || response == "Saved" || response == "SAVED"
        display_saved_locations(user)
        options_to_start_new_search(user)
    else
        puts "------------------------------------"
        puts "Omg you're amazing, but I said these are your options:"
        options_after_saving(businesses, num, user)
    end
end

def options_to_start_new_search(user)
    puts "------------------------------------"
    puts "To start new search with current location, enter 'Search'"
    puts "To change your current location and start new search, enter 'Change'"
    puts "To exit app, enter 'Exit'"
    puts "------------------------------------"
    response = gets.chomp
    if response == "search" || response == "Search" || response == "SEARCH"
        start_search(user.user_location, user)
    elsif response == "change" || response == "Change" || response == "CHANGE"
        new_user_address = get_new_user_location
        change_user_location(user, new_user_address)
        start_search(new_user_address, user)
    elsif response == "exit" || response == "Exit" || response == "EXIT"
        puts "------------------------------------"
        puts "Thank you for using our App, bye."
        puts "------------------------------------"
    else
        puts "------------------------------------"
        puts "Sigh... I guess you really don't know how to read"
        puts "How did you manage to open the app?"
        puts "------------------------------------"
        options_to_start_new_search(user)
    end
end

def last_want_to_save?(count)
    puts "------------------------------------"
    puts "enter '#{count}' to save _ #{count}"
    puts "enter '#{count + 1}' to save option #{count + 1}"
    puts "enter '#{count + 2}' to save option #{count + 2}"
    puts "enter '#{count + 3}' to save option #{count + 3}"
    puts "enter '#{count + 4}' to save option #{count + 4}"
    puts "These are all available options from this location"
    puts "To change your current location and start new search, enter 'Change'"
    puts "To view your saved locations, enter 'Saved'"
    puts "To exit app, enter 'Exit'"
    puts "To permanently delete user and exit app, enter 'Delete User'"
    puts "------------------------------------"
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
    elsif response == "change" || response == "Change" || response == "CHANGE"
        new_user_address = get_new_user_location
        change_user_location(user, new_user_address)
        start_search(new_user_address, user)
    elsif response == "saved" || response == "Saved" || response == "SAVED"
        display_saved_locations(user)
        options_to_start_new_search(user)
    elsif response == "exit" || response == "Exit" || response == "EXIT"
        puts "------------------------------------"
        puts "Thank you for using our App, bye."
        puts "------------------------------------"
    elsif response == "delete user" || response == "Delete User" || response == "DELETE USER"
        puts "------------------------------------"
        puts "Thank you for using our App, bye."
        delete_user(user)
        puts "------------------------------------"
    else
        puts "------------------------------------"
        puts "That won't do. These are your options: "
        want_to_save?(1)
        last_get_response_to_save_or_not(businesses, count, num, user)
    end
end

def last_options_after_saving(businesses, num, user)
    puts "------------------------------------"
    puts "To change your current location and start new search, enter 'Change'"
    puts "To view your saved locations, enter 'Saved'"
    puts "------------------------------------"
    response = gets.chomp
    if response == "next" || response == "Next" || response == "NEXT"
        if num == 15
            display_five_place_names(businesses, num)
            last_want_to_save?(num + 1)
            return last_get_response_to_save_or_not(businesses, num + 1, num + 5, user)
        end
        display_five_place_names(businesses, num) # display business names of 5-10
        want_to_save?(num + 1) # 6 - 10
        get_response_to_save_or_not(businesses, num + 1, num + 5, user)        
    elsif response == "change" || response == "Change" || response == "CHANGE"
        new_user_address = get_new_user_location
        change_user_location(user, new_user_address)
        start_search(new_user_address, user)
    elsif response == "saved" || response == "Saved" || response == "SAVED"
        display_saved_locations(user)
        options_to_start_new_search(user)
    else
        puts "------------------------------------"
        puts "Sigh... I guess you really don't know how to read"
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
    puts "*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*"
    puts ""
    all_saved = user.saved_locations.map {|location| location.name}
    if all_saved.length == 0
        puts "** There are currently no saved locations **"
    else
        puts all_saved
    end
    puts ""
    puts "*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*"
end

# "* * * * * * * * * * * * * * * * * * *"
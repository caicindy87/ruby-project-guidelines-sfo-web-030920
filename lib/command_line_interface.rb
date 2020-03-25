# what user sees and will interact with
# 

def hello
    puts 'hello world'
    puts 'enter 1 to find 5 random places'
    user_input = gets.chomp # user input is string data type
    if user_input.to_i == 1 # can change user input to integer
        display_results
        want_to_save?
    else
        puts "bye"
    end
end

def want_to_save?
    puts "press 1 to save option 1"
    puts "press 2 to save option 2"
    puts "press 3 to save option 3"
    puts "press 4 to save option 4"
    puts "press 5 to save option 5"

    user_input = gets.chomp.to_i

    # creates 5 new Place instances
    get_businesses_from_yelp_api.each do |business|
        Place.create(name: business["name"], address: "#{business["location"]["display_address"][0]}, #{business["location"]["display_address"][1]}")
    end

    if user_input.to_i == 1 # can change user input to integer
        puts options[0]
    elsif user_input.to_i == 2        
        puts options[1]
    elsif user_input.to_i == 3
        puts options[2]
    elsif user_input.to_i == 4
        puts options[3]
    elsif user_input.to_i == 5
        puts options[4]
    else
        puts "That's not a correct input number."
    end
end

def display_results
    display_five_place_names
end

# when user wants to save location, that is when you create new instance of place and saved_location
# what if they want to save multiple locations?

# def save_a_location(number)
#     options = get_businesses_from_yelp_api.each do |business|
#         Place.create(name: business["name"], address: "#{business["location"]["display_address"][0]}, #{business["location"]["display_address"][1]}")
#     end

#     if user_input.to_i == 1 # can change user input to integer
#         options[0]
#     elsif user_input.to_i == 2        
#         options[1]
#     elsif user_input.to_i == 3
#         options[2]
#     elsif user_input.to_i == 4
#         options[3]
#     elsif user_input.to_i == 5
#         options[4]
#     else
#         puts "That's not a correct input number."
#     end
# end



# def display_saved_locations

# end
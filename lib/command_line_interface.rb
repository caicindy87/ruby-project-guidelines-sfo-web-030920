# what user sees and will interact with
# 

def hello
    puts 'hello world'
    puts 'enter 1 to find 5 random places'
    user_input = gets.chomp # user input is string data type
    if user_input.to_i == 1 # can change user input to integer
        display_results
    else
        puts "bye"
    end
end

def display_results
    display_five_place_names
end

# when user wants to save location, that is when you create new instance of place and saved_location
# what if they want to save multiple locations?

def save_a_location
    puts "press 1 to save option 1"
    puts "press 2 to save option 2"
    puts "press 3 to save option 3"
    puts "press 4 to save option 4"
    puts "press 5 to save option 5"

    if user_input.to_i == 1 # can change user input to integer
        
    else
        puts "bye"
    end
end


# def display_saved_locations

# end
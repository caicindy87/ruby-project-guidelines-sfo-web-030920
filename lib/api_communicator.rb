require 'rest-client'
require 'json'
require 'dotenv/load'


def get_businesses_from_yelp_api # returns an array of five hashes (each hash contains one business)
    yelp = ENV["YELP_API_KEY"]
    response_string = RestClient.get("https://api.yelp.com/v3/businesses/search?location='1460 Mission Street, San Francisco, CA 94103'&limit=5&radius=10000", headers={"Authorization" => "Bearer #{yelp}", "x-requested-with": "xmlhttprequest"})
    response_hash = JSON.parse(response_string)["businesses"]
end

# will need to interpolate user's current location (address) to the URL


# add parameters after search by adding ? and then the parameters
# the address (aka location) is a string
# if want to add more parameters to search, separate by &
# call this method in seeds file so that you can iterate through
# limit it to 5 results/outputs (limit parameter)
# radius in meters



def display_five_place_names
    get_businesses_from_yelp_api.each do |business|
        puts business["name"] # do we want to just show name and address?
    end
end

# creates 5 new Place instances
# get_businesses_from_yelp_api.each do |business|
#    Place.create(name: business["name"], address: "#{business["location"]["display_address"][0]}, #{business["location"]["display_address"][1]}")
# end



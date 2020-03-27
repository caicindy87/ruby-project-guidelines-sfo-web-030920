require 'rest-client'
require 'json'
require 'dotenv/load'


def get_businesses_from_yelp_api(user_location) # returns an array of hashes (each hash contains one business)
    yelp = ENV["YELP_API_KEY"]
    response_string = RestClient.get("https://api.yelp.com/v3/businesses/search?location=#{user_location}&limit=20&radius=10000", headers={"Authorization" => "Bearer #{yelp}", "x-requested-with": "xmlhttprequest"})
    response_hash = JSON.parse(response_string)["businesses"]
end



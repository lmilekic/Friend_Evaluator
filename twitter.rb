def get_tweets(screen_name)

  # Now you will fetch /1.1/statuses/user_timeline.json,
  # returns a list of public Tweets from the specified
  # account.
  baseurl = "https://api.twitter.com"
  path    = "/1.1/statuses/user_timeline.json"
  query   = URI.encode_www_form(
  "screen_name" => "#{screen_name}",
  "count" => 20,
  "include_rts" => "false",
  )
  address = URI("#{baseurl}#{path}?#{query}")
  request = Net::HTTP::Get.new address.request_uri
  #request.add_field("Authorization", "Bearer #{@access_token}")
  # Print data about a list of Tweets
  def print_timeline(tweets)
    tweets.each do |tweet|
      puts tweet
      puts
    end
  end

  # Set up HTTP.
  http             = Net::HTTP.new address.host, address.port
  http.use_ssl     = true
  http.verify_mode = OpenSSL::SSL::VERIFY_PEER
  http.set_debug_output($stdout)
  # If you entered your credentials in the first
  # exercise, no need to enter them again here. The
  # ||= operator will only assign these values if
  # they are not already set.
  consumer_key ||= OAuth::Consumer.new "aL34AMzbNHnf7q46gLg0LgdHg", "ZdWiZGUxBRIHDQQhoHrAN928eGCgQydCn0eu1zIxwAQ350tsew"
  access_token ||= OAuth::Token.new "1297451042-zToT2tLLH30uOdVJIR4Tc6Y5RbazkfbMQTBIjLm", "WOslSrfn9pYrvdTYI8PuRmG9s2BHOxABSQSAK7Y8QWK6V"

  # Issue the request.
  request.oauth! http, consumer_key, access_token
  http.start
  response = http.request request
  puts "response code is: " + response.code.to_s
  puts "response body is: " + response.body.to_s
  # Parse and print the Tweet if the response code was 200
  tweets = nil
  if response.code == '200' then
    tweets = JSON.parse(response.body)
    #print_timeline(tweets)
  end
  tweets
end

def get_friends(screen_name)

  # Now you will fetch /1.1/statuses/user_timeline.json,
  # returns a list of public Tweets from the specified
  # account.
  baseurl = "https://api.twitter.com"
  path    = "/1.1/friends/list.json"
  query   = URI.encode_www_form(
  "screen_name" => "#{screen_name}",
  "count" => 100,
  )
  address = URI("#{baseurl}#{path}?#{query}")
  request = Net::HTTP::Get.new address.request_uri
  request.add_field("Authorization", "Bearer #{@access_token}")


  # Set up HTTP.
  http             = Net::HTTP.new address.host, address.port
  http.use_ssl     = true
  http.verify_mode = OpenSSL::SSL::VERIFY_PEER
  http.set_debug_output($stdout)
  # If you entered your credentials in the first
  # exercise, no need to enter them again here. The
  # ||= operator will only assign these values if
  # they are not already set.
  #consumer_key ||= OAuth::Consumer.new "aL34AMzbNHnf7q46gLg0LgdHg", "ZdWiZGUxBRIHDQQhoHrAN928eGCgQydCn0eu1zIxwAQ350tsew"
  #access_token ||= OAuth::Token.new "1297451042-zToT2tLLH30uOdVJIR4Tc6Y5RbazkfbMQTBIjLm", "WOslSrfn9pYrvdTYI8PuRmG9s2BHOxABSQSAK7Y8QWK6V"

  # Issue the request.
  #request.oauth! http, consumer_key, access_token
  http.start
  response = http.request request
  puts "response code is: " + response.code.to_s
  puts "response body is: " + response.body.to_s
  # Parse and print the Tweet if the response code was 200
  friends = nil
  if response.code == '200' then
    friends = JSON.parse(response.body)
  end
  friends['users']
end

def get_bearer_token()
  baseurl = "https://api.twitter.com"
  path    = "/oauth2/token"

  enc = Base64.strict_encode64("aL34AMzbNHnf7q46gLg0LgdHg:ZdWiZGUxBRIHDQQhoHrAN928eGCgQydCn0eu1zIxwAQ350tsew")
  address = URI("#{baseurl}#{path}")
  request = Net::HTTP::Post.new address.request_uri

  request.set_form_data(
  "grant_type" => "client_credentials",
)
  request.add_field("Authorization", "Basic #{enc}")
  #request.add_field("Content-Type", "application/x-www-form-urlencoded;charset=UTF-8")


  # Set up HTTP.
  http             = Net::HTTP.new address.host, address.port
  http.use_ssl     = true
  http.verify_mode = OpenSSL::SSL::VERIFY_PEER
  #http.set_debug_output($stdout)

  # If you entered your credentials in the first
  # exercise, no need to enter them again here. The
  # ||= operator will only assign these values if
  # they are not already set.
  #consumer_key ||= OAuth::Consumer.new "aL34AMzbNHnf7q46gLg0LgdHg", "ZdWiZGUxBRIHDQQhoHrAN928eGCgQydCn0eu1zIxwAQ350tsew"
  #access_token ||= OAuth::Token.new "1297451042-zToT2tLLH30uOdVJIR4Tc6Y5RbazkfbMQTBIjLm", "WOslSrfn9pYrvdTYI8PuRmG9s2BHOxABSQSAK7Y8QWK6V"


  # Issue the request.
  #request.oauth! http, consumer_key#, access_token
  http.start
  response = http.request request

  # Parse and print the Tweet if the response code was 200
  bearer_token = nil
  if response.code == '200' then
    bearer_token = JSON.parse(response.body)
  end
  puts "***************************************"
  puts response.body.to_s
  bearer_token
end

def test_crap()

  # Now you will fetch /1.1/statuses/user_timeline.json,
  # returns a list of public Tweets from the specified
  # account.
  baseurl = "https://api.twitter.com"
  path    = "/1.1/application/rate_limit_status.json"
  query   = URI.encode_www_form(
  )
  address = URI("#{baseurl}#{path}?#{query}")
  request = Net::HTTP::Get.new address.request_uri
  request.add_field("Authorization", "Bearer #{@access_token}")


  # Set up HTTP.
  http             = Net::HTTP.new address.host, address.port
  http.use_ssl     = true
  http.verify_mode = OpenSSL::SSL::VERIFY_PEER
  http.set_debug_output($stdout)
  # If you entered your credentials in the first
  # exercise, no need to enter them again here. The
  # ||= operator will only assign these values if
  # they are not already set.
  #consumer_key ||= OAuth::Consumer.new "aL34AMzbNHnf7q46gLg0LgdHg", "ZdWiZGUxBRIHDQQhoHrAN928eGCgQydCn0eu1zIxwAQ350tsew"
  #access_token ||= OAuth::Token.new "1297451042-zToT2tLLH30uOdVJIR4Tc6Y5RbazkfbMQTBIjLm", "WOslSrfn9pYrvdTYI8PuRmG9s2BHOxABSQSAK7Y8QWK6V"

  # Issue the request.
  #request.oauth! http, consumer_key, access_token
  http.start
  response = http.request request
  puts "response code is: " + response.code.to_s
  puts "response body is: " + response.body.to_s
  # Parse and print the Tweet if the response code was 200
  friends = nil
  if response.code == '200' then
    friends = JSON.parse(response.body)
  end
  friends
end

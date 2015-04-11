require 'sinatra'
require 'rubygems'
require 'oauth'
require 'json'

get '/:name' do
  tweets = get_tweets(params['name'])
  tweets_with_scores = {}
  tweets.each do |tweet|
    tweets_with_scores[tweet['user']['screen_name']] = 50
  end
  @scores = tweets_with_scores.to_json
  erb :index
end


def get_tweets(screen_name)

  # Now you will fetch /1.1/statuses/user_timeline.json,
  # returns a list of public Tweets from the specified
  # account.
  baseurl = "https://api.twitter.com"
  path    = "/1.1/statuses/user_timeline.json"
  query   = URI.encode_www_form(
  "screen_name" => "#{screen_name}",
  "count" => 5,
  )
  address = URI("#{baseurl}#{path}?#{query}")
  request = Net::HTTP::Get.new address.request_uri

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

  # Parse and print the Tweet if the response code was 200
  tweets = nil
  if response.code == '200' then
    tweets = JSON.parse(response.body)
    print_timeline(tweets)
  end
  tweets
end

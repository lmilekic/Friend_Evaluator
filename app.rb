require 'sinatra'
require 'oauth'
require 'json'
require 'indico'
require 'base64'
require_relative 'twitter.rb'
before do
  Indico.api_key = '903b952bb105cfad08887c3838a05e38'
  @access_token = "AAAAAAAAAAAAAAAAAAAAAMXMfAAAAAAAD7cHhWl8SxqFC3AylZRm%2B9y%2B%2Bqk%3DBrVfD54C1vHeG2vZ6aFwBQPL7tUB3cMKulkrevcvEgMxzuDD6r"
end
#access_token=>"AAAAAAAAAAAAAAAAAAAAAMXMfAAAAAAAD7cHhWl8SxqFC3AylZRm%2B9y%2B%2Bqk%3DBrVfD54C1vHeG2vZ6aFwBQPL7tUB3cMKulkrevcvEgMxzuDD6r"
set :port, 8000
get '/' do
  #test_crap
  #get_bearer_token
  get_tweets('Shmaggs317')
  erb :index
end

get '/search' do
  tweets_with_scores = []
  friends = get_friends(params['name'])
  friends.each do |friend|
    friend_info = {}
    friend_info['name'] = friend['name']
    friend_info['screen_name'] = friend['screen_name']
    friend_info['happiness'] = get_happiness(friend['screen_name'])
    tweets_with_scores << friend_info
  end
  @scores = tweets_with_scores#.to_json 
  erb :search
end


def full_tweet_text(screen_name)
  tweets = get_tweets(screen_name)
  result = []
  tweets.each do |tweet|
    result << tweet['text']
  end
  result
end

def get_happiness(screen_name)
  arr = Indico.batch_sentiment(full_tweet_text(screen_name))
  arr.inject{|sum, el| sum + el}.to_f / arr.size
  #puts Indico.sentiment("best day ever")
end

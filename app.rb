require 'sinatra'
require 'oauth'
require 'json'
require 'indico'
require_relative 'twitter.rb'
before do
  Indico.api_key = 'e693133164829165603f11c4bcd8c156'
end

get '/:name' do

  tweets_with_scores = []
  friends = get_friends(params['name'])
  friends.to_s
  friends.each do |friend|
    friend_info = {}
    friend_info['name'] = friend['name']
    friend_info['screen_name'] = friend['screen_name']
    friend_info['happiness'] = get_happiness(friend['screen_name'])
    tweets_with_scores << friend_info
  end
  @scores = tweets_with_scores#.to_json
  erb :index
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

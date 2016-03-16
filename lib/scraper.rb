##
# This module provides the shared functionality for the scraping scripts.

require 'redis'
require 'twitter'

module Scraper

  # Data store key template for tweet descriptions.
  TWEET_KEY = "tweet:%{id}"

  # Data store key template for user descriptions.
  USER_KEY = "user:%{id}"

  # Data store key for impact descriptions.
  IMPACT_KEY = "impact:%{id}:%{time}"

  # Data store key for the set of tweets.
  TWEET_SET = "tweets"

  # Data store key for the set of users.
  USER_SET = "users"

  ##
  # Return a connection to the data store.
  def Scraper.datastore
      return Redis.new(:url => ENV["REDIS_URL"])
  end

  ##
  # Return a client for the Twitter streaming API.
  def Scraper.stream
    return Twitter::Streaming::Client.new do |config|
      config.consumer_key = ENV["CONSUMER_KEY"]
      config.consumer_secret = ENV["CONSUMER_SECRET"]
      config.access_token = ENV["ACCESS_TOKEN"]
      config.access_token_secret = ENV["ACCESS_SECRET"]
    end
  end

  ##
  # Return a client for the Twitter REST API.
  def Scraper.rest
    return Twitter::REST::Client.new do |config|
      config.consumer_key = ENV["CONSUMER_KEY"]
      config.consumer_secret = ENV["CONSUMER_SECRET"]
      config.access_token = ENV["ACCESS_TOKEN"]
      config.access_token_secret = ENV["ACCESS_SECRET"]
    end
  end

  ##
  # Calls the given block for each status retrieved from the given
  # datastore.
  def Scraper.tweets(db)
    db.scan_each(:match => TWEET_KEY % {:id => "*"}) do |key|
      yield db.get(key)
    end
  end

  ##
  # Calls the given block for each user retrieved from the given
  # datastore.
  def Scraper.users(db)
    db.scan_each(:match => USER_KEY % {:id => "*"}) do |key|
      yield db.get(key)
    end
  end

  ##
  # Calls the given block for each impact record from the given
  # datastore.
  def Scraper.impact(db)
    db.scan_each(:match => IMPACT_KEY % {:id => "*", :time => "*"}) do |key|
      yield db.get(key)
    end
  end

end

# Twitter Scraper

A general-purpose Twitter scraper that follows the public feed and collects
tweets, user profiles, and measures of impact over time in a Redis store.

## Installation

Install the dependencies first:

    gem install twitter redis

And then clone this repository:

    git clone https://github.com/brett-lempereur/twitter-scraper

## Usage

You'll need to define the following environment variables:

* `REDIS_URL`: The URL of the Redis store.
* `ACCESS_TOKEN`: Twitter API access token.
* `ACCESS_SECRET`: Twitter API access secret.
* `CONSUMER_TOKEN`: Twitter API consumer token.
* `CONSUMER_SECRET`: Twitter API consumer secret.

Ensure that your Redis instance is running, then start the background
scripts:

    ./collect-impact
    ./collect-users

Now start the tweet collection script, supplying a list of keywords to
follow:

    ./collect-tweets keyword keyword keyword...

If you need to export data to CSV/JSON, or to clear the datastore, use
the following commands:

    ./export-csv filename.csv
    ./export-json filename.json
    ./clear-datastore

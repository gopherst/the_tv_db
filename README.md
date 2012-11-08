# TheTvDB [![Build Status](https://travis-ci.org/jassa/the_tv_db.png)](https://travis-ci.org/jassa/the_tv_db) [![Dependency Status](https://gemnasium.com/jassa/the_tv_db.png)](https://gemnasium.com/jassa/the_tv_db) [![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/jassa/the_tv_db)

Ruby API Client for TheTvDB.com

## Installation

    $ gem install the_tv_db

Or add this line to your application's Gemfile:

    gem 'the_tv_db'

And then execute:

    $ bundle

## Usage

```ruby
require "the_tv_db"

api = TheTvDB.new

# You can search for a series name
api.series.search("Fringe")
=> [#<TheTvDB::Series::Collection id: "82066", api_id: "82066", banner: "graphical/82066-g38.jpg", first_aired: "2008-08-26", imdb_id: "tt1119644", name: "Fringe", language: "en", overview: "The series follows a Federal Bureau of Investigatio...", zap2it_id: "SH01059103">]

# Once you have the series ID you can use it to find its full information
series = api.series.find("82066")
=> #<TheTvDB::Series id: "82066", actors: "|Anna Torv|Joshua Jackson|John Noble|Jasika Nicole|...", added: nil, added_by: nil, airs_day_of_week: "Friday", airs_time: "9:00 PM", banner: "graphical/82066-g38.jpg", content_rating: "TV-14", fanart: "fanart/original/82066-78.jpg", first_aired: "2008-08-26", genre: "|Drama|Science-Fiction|", imdb_id: "tt1119644", language: "en", last_updated: "1351221356", network: "FOX", network_id: nil, overview: "The series follows a Federal Bureau of Investigatio...", rating: "8.7", rating_count: "571", runtime: "60", poster: "posters/82066-53.jpg", series_id: "75146", series_name: "Fringe", status: "Continuing", zap2it_id: "SH01059103">

## ...Even with episodes
series.episodes
=> [#<TheTvDB::Episode id: "694851", absolute_number: nil, airs_after_season: nil, airs_before_episode: "1", airs_before_season: "1", combined_episode_number: "1", combined_season: "0", director: nil, dvd_chapter: nil, dvd_disc_id: nil, dvd_episode_number: nil, dvd_season: nil, ep_img_flag: "1", name: "Unaired Pilot", number: "1", filename: "episodes/82066/694851.jpg", first_aired: nil, guest_stars: nil, imdb_id: nil, language: "en", last_updated: "1263338464", overview: nil, production_code: nil, rating: nil, rating_count: "0", season_id: "32605", season_number: "0", series_id: "82066", ... (96 more)

# Some methods require an API key,
# For example: searching for episodes by air_date
api.episodes.find(series_id="82066", air_date="2012-11-16")
TheTvDB::TheTvDBError: You must have an Application Key to use this interface

api = TheTvDB.new(api_key: your_api_key)
api.episodes.find(series_id="82066", air_date="2012-11-16")
=> [#<TheTvDB::Episode id: "4393016", absolute_number: nil, airs_after_season: nil, airs_before_episode: nil, airs_before_season: nil, combined_episode_number: "7", combined_season: "5", director: nil, dvd_chapter: nil, dvd_disc_id: nil, dvd_episode_number: nil, dvd_season: nil, ep_img_flag: nil, name: "52010", number: "7", filename: nil, first_aired: "2012-11-16", guest_stars: nil, imdb_id: nil, language: "en", last_updated: "1350927372", overview: "The team orchestrates an event of its own.", production_code: nil, rating: nil, rating_count: nil, season_id: "494897", season_number: "5", series_id: "82066", writer: nil>]
```

## Feature & Development Roadmap

* Series banners
* Season posters
* Fan-art posters
* List of supported languages

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Copyright

Copyright (c) 2012 Javier Saldana. See LICENSE for details.

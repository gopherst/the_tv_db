module TheTvDB
  class Episode < API
    include Model
    
    class << self
      
      # Public: Find an episode by air date.
      #
      # This is useful for shows that don't contain season and episode info, 
      # but rather have the date in the title.
      #
      # series_id  - The ID of the series.
      # air_date   - The air date of the episode.
      # lang       - The language of the episode.
      #
      # Examples
      #
      #    find("82066", "2012-11-16")
      #    find("82066", "11/16/2012", "fr")
      #
      # Returns array of TheTvDB::Episode objects.
      def find(series_id, air_date=nil, lang="en")
        data = request("GetEpisodeByAirDate.php", { 
          apikey:   TheTvDB.api_key,
          seriesid: series_id,
          airdate:  air_date,
          language: lang
        })["Data"]
        
        raise TheTvDBError, data["Error"] if data["Error"]
        
        episodes = data["Episode"]
        
        case episodes
        when Hash
          [ new(episodes) ]
        when Array
          episodes.collect { |episode| new(episode) }
        else
          []
        end
      end
      alias :get :find
    end
    
    ATTRS_MAP = {
      :id                      => "id",
      :absolute_number         => "absolute_number",
      :airs_after_season       => "airsafter_season",
      :airs_before_episode     => "airsbefore_episode",
      :airs_before_season      => "airsbefore_season",
      :combined_episode_number => "Combined_episodenumber",
      :combined_season         => "Combined_season",
      :director                => "Director",
      :dvd_chapter             => "DVD_chapter",
      :dvd_disc_id             => "DVD_discid",
      :dvd_episode_number      => "DVD_episodenumber",
      :dvd_season              => "DVD_season",
      :ep_img_flag             => "EpImgFlag",
      :name                    => "EpisodeName",
      :number                  => "EpisodeNumber",
      :filename                => "filename",
      :first_aired             => "FirstAired",
      :guest_stars             => "GuestStars",
      :imdb_id                 => "IMDB_ID",
      :language                => "Language",
      :last_updated            => "lastupdated",
      :overview                => "Overview",
      :production_code         => "ProductionCode",
      :rating                  => "Rating",
      :rating_count            => "RatingCount",
      :season_id               => "seasonid",
      :season_number           => "SeasonNumber",
      :series_id               => "seriesid",
      :writer                  => "Writer"
    }.freeze
    
    attr_accessor *ATTRS_MAP.keys
    
  end # Episode
end # TheTvDB
module TheTvDB
  class Episode < Model
    
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
      #    search("82066", "2012-11-16")
      #    search("82066", "11/16/2012", "fr")
      #
      # Returns TheTvDB::Episode object
      def search(series_id, air_date=nil, lang="en")
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

    def initialize(params=nil)
      self.attributes = params
    end
    
    def attributes=(params=nil)
      params.each do |attr, value|
        begin
          self.public_send("#{ATTRS_MAP.key(attr)}=", value)
        rescue NoMethodError
          raise UnknownAttributeError, "unknown attribute: #{attr}"
        end
      end if params
    end
    
    def attributes
      attrs = {}
      ATTRS_MAP.keys.each do |name|
        attrs[name] = send(name)
      end
      attrs
    end
    
    def inspect
      inspection = unless id.nil?
        ATTRS_MAP.keys.collect { |name|
          "#{name}: #{attribute_for_inspect(name)}"
        }.compact.join(", ")
       else
         "not initialized"
       end
      "#<#{self.class} #{inspection}>"
    end
    
  end # Series
end # TheTvDB
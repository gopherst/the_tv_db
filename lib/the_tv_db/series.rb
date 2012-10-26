module TheTvDB
  class Series < API
    include Model

    class << self
      def search(name, lang="en")
        data = request("GetSeries.php", { seriesname: name, language: lang })["Data"]
        return [] if data.nil?
        
        series = data["Series"]
        
        case series
        when Hash
          [ Series::Collection.new(series) ]
        when Array
          series.collect { |serie| Series::Collection.new(serie) }
        else
          []
        end
      end
      
      def find(id)
        data = request("/data/series/#{id}/all/")["Data"]
        record = new(data["Series"])
        record.episodes = data["Episode"]
        return record
      rescue MultiXml::ParseError
        raise RecordNotFound, "Couldn't find series with ID=#{id}"
      end
      alias :get :find
    end
    
    ATTRS_MAP = {
      :id               => "id",
      :actors           => "Actors",
      :added            => "added",
      :added_by         => "addedBy",
      :airs_day_of_week => "Airs_DayOfWeek",
      :airs_time        => "Airs_Time",
      :banner           => "banner",
      :content_rating   => "ContentRating",
      :fanart           => "fanart",
      :first_aired      => "FirstAired",
      :genre            => "Genre",
      :imdb_id          => "IMDB_ID",
      :language         => "Language",
      :last_updated     => "lastupdated",
      :network          => "Network",
      :network_id       => "NetworkID",
      :overview         => "Overview",
      :rating           => "Rating",
      :rating_count     => "RatingCount",
      :runtime          => "Runtime",
      :poster           => "poster",
      :series_id        => "SeriesID",
      :series_name      => "SeriesName",
      :status           => "Status",
      :zap2it_id        => "zap2it_id"
    }.freeze
    
    attr_accessor *ATTRS_MAP.keys, :episodes
    
    def episodes=(episodes)
      @episodes = case episodes
      when Hash
        [ Episode.new(episodes) ]
      when Array
        episodes.collect { |episode| Episode.new(episode) }
      else
        []
      end
    end
    
  end # Series
end # TheTvDB
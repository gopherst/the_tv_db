module TheTvDB
  class Series < Model

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
      attributes = ATTRS_MAP.keys
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
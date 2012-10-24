module TheTvDB
  class Series < API

    class << self
      def search(name)
        data = request("GetSeries.php", { seriesname: name })["Data"]
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
        new(request("/data/series/#{id}/all/")["Data"]["Series"])
      rescue MultiXml::ParseError
        raise RecordNotFound, "Couldn't find series with ID=#{id}"
      end
      alias :get :find
    end
    
    ATTRS_MAP = {
      "id"             => :id,
      "Actors"         => :actors,
      "Airs_DayOfWeek" => :airs_day_of_week,
      "Airs_Time"      => :airs_time,
      "ContentRating"  => :content_rating,
      "FirstAired"     => :first_aired,
      "Genre"          => :genre,
      "IMDB_ID"        => :imdb_id,
      "Language"       => :language,
      "Network"        => :network,
      "NetworkID"      => :network_id,
      "Overview"       => :overview,
      "Rating"         => :rating,
      "RatingCount"    => :rating_count,
      "Runtime"        => :runtime,
      "SeriesID"       => :series_id,
      "SeriesName"     => :series_name,
      "Status"         => :status,
      "added"          => :added,
      "addedBy"        => :added_by,
      "banner"         => :banner,
      "fanart"         => :fanart,
      "lastupdated"    => :last_updated,
      "poster"         => :poster,
      "zap2it_id"      => :zap2it_id
    }.freeze
    
    attr_accessor *ATTRS_MAP.values

    def initialize(params={})
      params.each do |attr, value|
        begin
          self.public_send("#{ATTRS_MAP[attr]}=", value)
        rescue NoMethodError
          raise UnknownAttributeError, "unknown attribute: #{attr}"
        end
      end if params
    end
    
  end # Series
end # TheTvDB
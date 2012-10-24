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
    
    attr_accessor *ATTRS_MAP.values, :episodes

    def initialize(params=nil)
      params.each do |attr, value|
        begin
          self.public_send("#{ATTRS_MAP[attr]}=", value)
        rescue NoMethodError
          raise UnknownAttributeError, "unknown attribute: #{attr}"
        end
      end if params
    end
    
    def inspect
      attributes = ATTRS_MAP.values
      inspection = if respond_to?(:id)
         ATTRS_MAP.values.collect { |name|
           if respond_to?(name)
             "#{name}: #{attribute_for_inspect(name)}"
           end
         }.compact.join(", ")
       else
         "not initialized"
       end
      "#<#{self.class} #{inspection}>"
    end
    
  end # Series
end # TheTvDB
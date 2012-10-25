module TheTvDB
  class Series::Collection
    
    ATTRS_MAP = {
      :id          => "seriesid",
      :api_id      => "id",
      :banner      => "banner",
      :first_aired => "FirstAired",
      :imdb_id     => "IMDB_ID",
      :name        => "SeriesName",
      :language    => "language",
      :overview    => "Overview",
      :zap2it_id   => "zap2it_id"
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
    
  end # Series::Collection
end # TheTvDB
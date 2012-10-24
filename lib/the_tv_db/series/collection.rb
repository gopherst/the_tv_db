module TheTvDB
  class Series::Collection
    
    ATTRS_MAP = {
      "seriesid"   => :id,
      "SeriesName" => :name,
      "language"   => :language,
      "Overview"   => :overview,
      "FirstAired" => :first_aired,
      "banner"     => :banner,
      "id"         => :api_id,
      "IMDB_ID"    => :imdb_id,
      "zap2it_id"  => :zap2it_id
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
    
  end # Series::Collection
end # TheTvDB
module TheTvDB
  class Series < API
    include Model

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

    attr_accessor *ATTRS_MAP.keys, :episodes, :banners, :actors

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

      def find(id, lang="en")
        format = TheTvDB.api_key ? :zip : :xml
        send("get_#{format}_by_id", id, lang)
      end
      alias :get :find

      private

      def get_xml_by_id(id, lang)
        data = request("/data/series/#{id}/all/").fetch("Data")
        record = new(data["Series"]) do |r|
          r.episodes = data["Episode"]
        end
      end

      def get_zip_by_id(id, lang)
        files = request("#{TheTvDB.api_key}/series/#{id}/all/#{lang}.zip")
        data = files["#{lang}.xml"].fetch("Data")
        record = new(data["Series"]) do |r|
          r.episodes = data["Episode"]
          r.build_banners_from_xml(files["banners.xml"])
          r.build_actors_from_xml(files["actors.xml"])
        end
      rescue ::Zip::ZipError
        get_xml_by_id(id, lang)
      end
    end

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

    def build_banners_from_xml(doc)
      build_association_from_xml(:banners, doc)
    end

    def build_actors_from_xml(doc)
      build_association_from_xml(:actors, doc)
    end

    def build_association_from_xml(association_name, doc)
      name_for_collection = association_name.to_s.capitalize
      name_for_element = name_for_collection[0..-2]

      elements = if doc && doc[name_for_collection]
        doc[name_for_collection][name_for_element]
      end

      self.send("#{association_name}=", elements)
    end

  end # Series
end # TheTvDB

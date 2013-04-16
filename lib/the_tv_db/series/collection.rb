module TheTvDB
  class Series::Collection
    include Model

    ATTRS_MAP = {
      :id          => "seriesid",
      :api_id      => "id",
      :alias       => "AliasNames",
      :banner      => "banner",
      :first_aired => "FirstAired",
      :imdb_id     => "IMDB_ID",
      :name        => "SeriesName",
      :network     => "Network",
      :language    => "language",
      :overview    => "Overview",
      :zap2it_id   => "zap2it_id"
    }.freeze

    attr_accessor *ATTRS_MAP.keys

  end # Series::Collection
end # TheTvDB

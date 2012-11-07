require "the_tv_db/series"
require "the_tv_db/series/collection"
require "the_tv_db/episode"

module TheTvDB
  class Client < API
        
    def series
      Series
    end
    
    def episodes
      Episode
    end
    
  end # Client
end # TheTvDB
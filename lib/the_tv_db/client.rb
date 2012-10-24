require "the_tv_db/series"
require "the_tv_db/series/collection"

module TheTvDB
  class Client < API
        
    def series
      Series
    end
    
  end # API
end # TheTvDB
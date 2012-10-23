require "the_tv_db/series"

module TheTvDB
  class Client < API
        
    def series
      Series
    end
    
  end # API
end # TheTvDB
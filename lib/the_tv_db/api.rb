require "the_tv_db/connection"

module TheTvDB
  class API
    extend Connection
    
    def initialize(options={}, &block)
      super()
      set_api_client
      self

      self.instance_eval(&block) if block_given?
    end
    
    # Assigns current api class
    def set_api_client
      TheTvDB.api_client = self
    end

  end # API
end # TheTvDB
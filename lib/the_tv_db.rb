require "the_tv_db/core_ext/string"
require "the_tv_db/version"
require "the_tv_db/errors"
require "the_tv_db/api"
require "the_tv_db/model"
require "the_tv_db/client"

module TheTvDB
  class << self
    
    attr_accessor :site, :endpoint
    
    @site = "http://thetvdb.com".freeze
    @endpoint = "http://thetvdb.com/api".freeze
    
    # Handle for the client instance
    attr_accessor :api_client
  
    def new(options={}, &block)
      @api_client = TheTvDB::Client.new(options, &block)
    end
    
    # Delegate to TheTvDB::Client
    #
    def method_missing(method, *args, &block)
      return super unless new.respond_to?(method)
      new.send(method, *args, &block)
    end
    
    def respond_to?(method, include_private = false)
      new.respond_to?(method, include_private) || super(method, include_private)
    end

  end # Self
end # TheTvDB
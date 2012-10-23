require "faraday"

module TheTvDB
  module Connection
    extend self
    API_URL = "http://thetvdb.com/api".freeze
    
    @connection = nil
    
    def connection
      @connection ||= Faraday.new(:url => API_URL) do |faraday|
        faraday.response :logger if ENV['DEBUG'] # log requests to STDOUT
        faraday.adapter  :typhoeus # make requests with Typhoeus
      end
    end
    
    def request(path, params={})
      connection.get(path, params)
    end
    
  end # Connection
end # TheTvDB
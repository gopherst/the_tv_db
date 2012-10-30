require "faraday"
require "the_tv_db/response"
require "the_tv_db/response/unzip"
require "the_tv_db/response/xmlize"

module TheTvDB
  module Connection
    extend self
    
    @connection = nil
    
    def connection
      @connection ||= Faraday.new(:url => TheTvDB::ENDPOINT) do |faraday|
        faraday.response :logger if ENV['DEBUG'] # log requests to STDOUT
        faraday.adapter  :typhoeus # make requests with Typhoeus
        faraday.use      TheTvDB::Response::Xmlize
        faraday.use      TheTvDB::Response::Unzip
      end
    end
    
    def request(path, params={})
      response = connection.get(path, params)
      response.body
    end
    
  end # Connection
end # TheTvDB
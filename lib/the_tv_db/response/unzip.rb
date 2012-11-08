module TheTvDB
  class Response::Unzip < Faraday::Response::Middleware

    def on_complete(env)
      if env[:response_headers]["content-type"] == "application/zip"
        env[:body] = TheTvDB::Zip.inflate(env[:body])
      end
      
      super
    end

  end # Response::Unzip
end # TheTvDB

require 'zip/zip'

module TheTvDB
  class Response::Unzip < Faraday::Response::Middleware

    def on_complete(env)
      env[:body] = unzip(env[:body]) if env[:response_headers]["content-type"] == "application/zip"      
      super
    end
    
    def unzip(body)
      zipped = Tempfile.new('thetvdb.com')
      begin
        zipped.write(body.force_encoding("utf-8"))
        unzipped = ::Zip::ZipFile.new(zipped)
        files = {}
        unzipped.each do |file|
          files[file.name] = file.get_input_stream.read
        end
        files
      ensure
        zipped.close
        zipped.unlink
      end
    end

  end # Response::Unzip
end # TheTvDB

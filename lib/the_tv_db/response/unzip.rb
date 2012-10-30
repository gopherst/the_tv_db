module TheTvDB
  class Response::Unzip < Response
    dependency 'zip/zip'
    
    define_parser do |body|
      ::Zip::ZipFile.new body
    end

    def parse(body)
      case body
      when String
        zip = Tempfile.new('unzip_me')
        begin
           zip.write(body)
           unzipped = self.class.parser.call(zip)
           files = {}
           unzipped.each do |file|
             files[file.name] = file.get_input_stream.read
           end
        ensure
           zip.close
           zip.unlink
        end
        files
      else
        body
      end
    rescue
      body
    end
    
  end # Response::Unzip
end # TheTvDB
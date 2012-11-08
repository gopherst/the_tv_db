require 'zip/zip'

module TheTvDB
  module Zip
    
    class << self
    
      # Decompresses string.
      def inflate(string)
        entries = {}
        deflated = deflate(string)
        deflated.each do |entry|
          entries[entry.name] = entry.get_input_stream.read
        end
        entries
      ensure
        tmp.close
        tmp.unlink
      end
      
      # Compresses the given string.
      def deflate(string)
        tmp.write(string.force_encoding("utf-8"))
        ::Zip::ZipFile.new(tmp)
      end
 
      private

      def tmp
        @tmp ||= Tempfile.new('thetvdb.com')
      end
  
    end

  end # Zip
end # TheTvDB

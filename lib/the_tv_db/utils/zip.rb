require 'zip/zip'

module TheTvDB
  class Zip
    
    attr_accessor :tmp
    
    def initialize
      @tmp = Tempfile.new('thetvdb.com')
    end
    
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

  end # Zip
end # TheTvDB

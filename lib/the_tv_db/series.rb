module TheTvDB
  class Series < API
    
    class << self
      def search(name)
        request("GetSeries.php", { seriesname: name })
      end
      
      def find(id)
        request("series/#{id}/all/")
      end
      alias :get :find
    end
    
    def name
    end
    
  end # Series
end # TheTvDB
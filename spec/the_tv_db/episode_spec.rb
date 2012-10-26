require "spec_helper"

describe TheTvDB::Episode do
  let(:api) { TheTvDB.new(api_key: "ASDF01234F0AF1368") }
  
  context ".search" do
    it "returns an episode obejct" do      
      stub_get("GetEpisodeByAirDate.php?airdate=2012-11-16&apikey=ASDF01234F0AF1368&language=en&seriesid=82066").
        to_return(:status => 200, :body => fixture("episodes/result.xml"))

      episodes = api.episodes.search("82066", "2012-11-16")
      episodes.count.should == 1
    end
    
    it "raises TheTvDBError when missing air_date" do
      stub_get("GetEpisodeByAirDate.php?airdate&apikey=ASDF01234F0AF1368&language=en&seriesid=82066").
        to_return(:status => 200, :body => fixture("episodes/air_date.xml"))

      expect {
        api.episodes.search("82066")
      }.to raise_error(TheTvDB::TheTvDBError)
    end
    
    it "raises TheTvDBError when missing API key" do
      stub_get("GetEpisodeByAirDate.php?airdate=2012-11-16&apikey&language=en&seriesid=82066").
        to_return(:status => 200, :body => fixture("episodes/api_key.xml"))

      TheTvDB.stub(:api_key).and_return(nil)
      expect {
        api.episodes.search("82066", "2012-11-16")
      }.to raise_error(TheTvDB::TheTvDBError)
    end 
  end
end
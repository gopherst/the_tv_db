require "spec_helper"

describe TheTvDB::Episode do
  let(:api) { TheTvDB.new(api_key: "ASDF01234F0AF1368") }
  
  context ".find" do
    context "when all parameters are valid" do
      before do
        stub_get("GetEpisodeByAirDate.php?airdate=2012-11-16&apikey=ASDF01234F0AF1368&language=en&seriesid=82066").
          to_return(:status => 200, :body => fixture("episodes/result.xml"))
      end
      
      let(:episodes) { api.episodes.find("82066", "2012-11-16") }
      
      it "returns an array" do
        episodes == Array
      end
      
      it "instantiates episode objects" do
        episodes.first == TheTvDB::Episode
      end
    end
    
    context "when missing air_date" do
      before do
        stub_get("GetEpisodeByAirDate.php?airdate&apikey=ASDF01234F0AF1368&language=en&seriesid=82066").
          to_return(:status => 200, :body => fixture("episodes/air_date.xml"))
      end
      
      it "raises TheTvDBError" do
        expect {
          api.episodes.find("82066")
        }.to raise_error(TheTvDB::TheTvDBError)
      end
    end
    
    context "when series_id doesn't exist" do
      before do
        stub_get("GetEpisodeByAirDate.php?airdate=2012-11-16&apikey=ASDF01234F0AF1368&language=en&seriesid=-1").
          to_return(:status => 200, :body => fixture("episodes/series_id.xml"))
      end
      
      it "raises TheTvDBError" do
        expect {
          api.episodes.find("-1", "2012-11-16")
        }.to raise_error(TheTvDB::TheTvDBError)
      end
    end
    
    context "when missing api_key" do
      before do
        TheTvDB.stub(:api_key).and_return(nil)
        stub_get("GetEpisodeByAirDate.php?airdate=2012-11-16&apikey&language=en&seriesid=82066").
          to_return(:status => 200, :body => fixture("episodes/api_key.xml"))
      end
      
      it "raises TheTvDBError when missing API key" do
        expect {
          api.episodes.find("82066", "2012-11-16")
        }.to raise_error(TheTvDB::TheTvDBError)
      end 
    end
  end
  
end
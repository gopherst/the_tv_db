require "spec_helper"

describe TheTvDB::Series do
  let(:api) { TheTvDB.new }
    
  context ".search" do
    it "returns an empty array when no results" do
      stub_request(:get, "http://thetvdb.com/api/GetSeries.php?language=en&seriesname=asdf").
        to_return(:body => fixture("series/empty.xml"))
      api.series.search("asdf").count.should == 0
    end

    it "returns an array with one result" do
      stub_request(:get, "http://thetvdb.com/api/GetSeries.php?language=en&seriesname=Fringe").
        to_return(:body => fixture("series/result.xml"))
      api.series.search("Fringe").count.should == 1
    end
    
    it "returns an array of results" do
      stub_request(:get, "http://thetvdb.com/api/GetSeries.php?language=en&seriesname=Wilfred").
        to_return(:body => fixture("series/results.xml"))
      api.series.search("Wilfred").count.should > 1
    end
  end
  
  context ".find" do
    it "returns a series obejct" do
      stub_request(:get, "http://thetvdb.com/data/series/82066/all/").
        to_return(:body => fixture("series/find.xml"))
      series = api.series.find("82066")
      series.id.should == "82066"
    end
    
    it "raises RecordNotFound" do
      stub_request(:get, "http://thetvdb.com/data/series/-1/all/").
        to_return(:status => 404, :body => fixture("series/404.html"), :headers => {})
      expect {
        api.series.find("-1")
      }.to raise_error(TheTvDB::RecordNotFound)
    end
  end
end
require "spec_helper"

describe TheTvDB::Series do
  let(:api) { TheTvDB.new }
    
  context ".search" do
    it "returns an empty array when no results" do
      stub_get("GetSeries.php?language=en&seriesname=asdf").
        to_return(:body => fixture("series/empty.xml"), :status => 200)
      api.series.search("asdf").count.should == 0
    end

    it "returns an array with one result" do
      stub_get("GetSeries.php?language=en&seriesname=Fringe").
        to_return(:body => fixture("series/result.xml"), :status => 200)
      api.series.search("Fringe").count.should == 1
    end
    
    it "returns an array of results" do
      stub_get("GetSeries.php?language=en&seriesname=Wilfred").
        to_return(:body => fixture("series/results.xml"), :status => 200)
      api.series.search("Wilfred").count.should > 1
    end
  end
  
  context ".find" do
    it "returns a series obejct" do
      stub_get("data/series/82066/all/", TheTvDB.site.to_s).
        to_return(:body => fixture("series/find.xml"), :status => 200)
      series = api.series.find("82066")
      series.id.should == "82066"
    end
    
    it "raises RecordNotFound" do
      stub_get("data/series/-1/all/", TheTvDB.site.to_s).
        to_return(:status => 404, :body => fixture("series/404.html"))
      expect {
        api.series.find("-1")
      }.to raise_error(TheTvDB::RecordNotFound)
    end
  end
end
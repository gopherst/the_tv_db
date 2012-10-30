require "spec_helper"

describe TheTvDB::Series do
  let(:api) { TheTvDB.new }
    
  context ".search" do
    it "returns an empty array when no results" do
      stub_get("GetSeries.php?language=en&seriesname=asdf").
        to_return(:status => 200, :body => fixture("series/empty.xml"))
      api.series.search("asdf").count.should == 0
    end

    it "returns an array with one result" do
      stub_get("GetSeries.php?language=en&seriesname=Fringe").
        to_return(:status => 200, :body => fixture("series/result.xml"))
      api.series.search("Fringe").count.should == 1
    end
    
    it "returns an array of results" do
      stub_get("GetSeries.php?language=en&seriesname=Wilfred").
        to_return(:status => 200, :body => fixture("series/results.xml"))
      api.series.search("Wilfred").count.should > 1
    end
  end
  
  context ".find" do
    
    context "when unauthenticated" do
      it "returns a series obejct" do
        stub_get("data/series/82066/all/", TheTvDB::SITE.to_s).
          to_return(:status => 200, :body => fixture("series/find.xml"))
        series = api.series.find("82066")
        series.id.should == "82066"
      end
      
      it "raises RecordNotFound" do
        stub_get("data/series/-1/all/", TheTvDB::SITE.to_s).
          to_return(:status => 404, :body => fixture("series/404.html"))
        expect {
          api.series.find("-1")
        }.to raise_error(TheTvDB::RecordNotFound)
      end
    end
    
    context "when api key is provided" do
      before(:all) do
        stub_get("ASDF01234F0AF1368/series/82066/all/en.zip").
          to_return(:status => 200, :body => fixture("series/en.zip"))
        api = TheTvDB.new(:api_key => "ASDF01234F0AF1368")
        @series = api.series.find("82066")
      end
      
      it "returns a series object" do
        @series.id.should == "82066"
      end
      
      it "assigns episodes" do
        @series.episodes.should_not be_nil
      end
      
      it "assigns banners" do
        @series.banners.should_not be_nil
      end
      
      it "assigns actors" do
        @series.actors.should_not be_nil
      end
    end
    
  end
end
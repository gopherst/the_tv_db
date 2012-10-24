require "spec_helper"

describe TheTvDB::Series do
  let(:api) { TheTvDB.new }
  
  context ".search" do
    it "returns an array of results" do
      api.series.search("Fringe") == Array
    end
  end
  
  context ".find" do
    it "returns a series obejct" do
      series = api.series.find("82066")
      series.id.should == "82066"
    end
    
    it "raises RecordNotFound" do
      expect {
        api.series.find("-1")
      }.to raise_error(TheTvDB::RecordNotFound)
    end
  end
end
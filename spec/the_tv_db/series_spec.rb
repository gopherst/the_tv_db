require "spec_helper"

describe TheTvDB::Series do
  let(:api) { TheTvDB.new }
  
  context ".search" do
    # TODO: fake http request
    it "returns array of results" do
      api.series.search("Fringe").body.should == fixture("fringe.xml").read
    end    
  end  
end
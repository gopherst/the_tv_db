require "spec_helper"

describe TheTvDB do
  
  it "sets an API key" do
    api_key = "ASDF01234F0AF1368"
    TheTvDB.new(api_key: api_key)
    TheTvDB.api_key == api_key
  end
  
  it "instantiates TheTvDB object without an API key" do
    TheTvDB.new
  end
  
end
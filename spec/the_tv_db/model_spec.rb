require "spec_helper"

class BasicEpisode
  include TheTvDB::Model

  ATTRS_MAP = {
    :id                      => "id",
    :combined_episode_number => "Combined_episodenumber",
    :combined_season         => "Combined_season",
    :director                => "Director",
  }

  attr_accessor *ATTRS_MAP.keys
end

describe TheTvDB::Model do

  it "sets known attributes" do
    attrs = {"Combined_episodenumber" => 1, "Director" => "Bob"}
    episode = BasicEpisode.new(attrs)
    episode.director.should == "Bob"
    episode.combined_episode_number.should == 1
  end

  it "stores unknown attributes in 'extras'" do
    attrs = {"Unknown" => "Foo", "Bar" => "Baz"}
    episode = BasicEpisode.new(attrs)
    episode.extras["Unknown"].should == "Foo"
    episode.extras["Bar"].should == "Baz"
  end

end

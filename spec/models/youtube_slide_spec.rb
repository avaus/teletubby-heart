require 'spec_helper'

describe YoutubeSlide do
  it "should have Slide as model" do
    YoutubeSlide.model_name.should eq("Slide")
  end
end
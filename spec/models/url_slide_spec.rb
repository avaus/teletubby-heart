require 'spec_helper'

describe UrlSlide do
  it "should have Slide as model" do
    UrlSlide.model_name.should eq("Slide")
  end
end
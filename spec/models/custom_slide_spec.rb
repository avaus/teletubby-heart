require 'spec_helper'

describe CustomSlide do
  it "should have Slide as model" do
    CustomSlide.model_name.should eq("Slide")
  end
end
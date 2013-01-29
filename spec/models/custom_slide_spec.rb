require 'spec_helper'

describe CustomSlide do
  before(:each) do
    @custom_slide = CustomSlide.create!(name: "testi", content: "<p>testi</p>", style: "/assets/templates/default.css")
  end
  it "should have Slide as model" do
    CustomSlide.model_name.should eq("Slide")
  end

  it "should create the url from id" do
    @custom_slide.url.should eql("/custom_slide/#{@custom_slide.id}")
  end
end
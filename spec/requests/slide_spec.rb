require 'spec_helper'

describe "Slide views" do
  before :each do
    @slide = Slide.create!(name:"testi")
  end
  it "show view should not fail" do
    get slide_url(@slide)
  end
  it "create view should not fail" do
    get url_for(controller: "slides", action: "new")
  end
  it "index view should not fail" do
    get url_for(controller: "slides", action: "index")
  end
end
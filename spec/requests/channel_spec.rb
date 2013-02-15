require 'spec_helper'

describe "Channel views" do
  before :each do
    @channel = Channel.create!(name:"testi")
  end
  it "show view should not fail" do
    get channel_url(@channel)
  end
  it "create view should not fail" do
    get url_for(controller: "channels", action: "new")
  end
  it "index view should not fail" do
    get url_for(controller: "channels", action: "index")
  end
end

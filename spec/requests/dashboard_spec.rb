require 'spec_helper'

describe "Dashboard" do
  describe "Home" do

    it "should have some text and a picture of a silly man" do
      get '/'
      assert_select "title", "TeletubbyHeart"
    end

    it "should return correct amount of channels" do
      6.times do
        Channel.create!(name: "TestChannel")
      end
      get '/'
      assigns[:channels].count.should == 4
    end
  end
end

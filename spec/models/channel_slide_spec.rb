require 'spec_helper'

describe ChannelSlide do
  before :each do
    @channel = Channel.create!(name: "Testi")
    @slide = Slide.create!(name: "Testislide")
  end
  describe "creation" do
    it "should create relation when slide is added" do
      @channel.slides << @slide
      @channel.reload
      @channel.slides.first.should == @slide
    end

    it "should create a relation when channel is added to slide" do
      @slide.channels << @channel
      @slide.reload
      @slide.channels.first.should == @channel
    end
  end

  describe "deletion" do
    it "should delete the relation only" do
      @channel.slides << @slide
      slide_count = @channel.slides.size 
      @channel.slides.destroy(@slide)
      @channel.slides.size.should == slide_count - 1
      @slide.should == Slide.find(@slide.id)
    end
    it "should not delete if it is the only relation in the default channel" do
      @channel.slides << @slide
      @channel.set_as_default
      expect { @channel.slides.destroy(@slide) }.to raise_error(OnlySlideInDefaultChannelDeletionException)
      @slide.should == Slide.find(@slide.id)
    end
  end
  
end

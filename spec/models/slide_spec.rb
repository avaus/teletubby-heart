require 'spec_helper'

describe "Slide" do
  describe "creation" do
    it "should create new valid slide" do
      slide = Slide.create!(:name => "first_slide")
      slide.reload
      slide.name.should == "first_slide"
    end
    it "should not be created with name nil" do
      slide = Slide.new(name: nil)
      slide.should_not be_valid
      slide.errors[:name].should_not be_nil
    end
    it "should not be created with too short name" do
      slide = Slide.new(name: "s")
      slide.should_not be_valid
      slide.errors[:name].should_not be_nil
    end
    it "should not be created with too long name" do
      slide = Slide.new(name: "l" * 101)
      slide.should_not be_valid
      slide.errors[:name].should_not be_nil
    end
    it "should have duration of 10" do
      slide = Slide.new(name: "test")
      slide.should be_valid
      slide.duration.should eq(10)
    end

  end

  describe "deletion" do
    it "should set deleted_at timestamp when destroyed" do
      slide = Slide.new(name: "foo")
      slide.save
      slide.destroy
      slide.should be_valid
      slide.deleted_at.should_not be_nil
    end

    it "should not list deleted slides" do
      Slide.create!(name: "foo1")
      Slide.create!(name: "foo2")
      slide = Slide.create!(name: "foo3")
      count1 = Slide.count
      slide.destroy
      Slide.count.should == count1-1
    end

    it "should delete all channel relations on deletion" do
      slide = Slide.create!(name: "foo")
      channel = Channel.create!(name: "ch")
      channel2 = Channel.create!(name: "ch2")
      slide.channels << channel
      slide.channels << channel2
      slide.destroy
      slide.channels.size.should == 0
    end

    describe "default channel" do
      before :each do
        @channel = Channel.create!(name: "Testi")
        @slide = Slide.create!(name: "Testislide")
        @slide2 = Slide.create!(name: "Testislide2")
        @channel.slides << @slide
        @channel.slides << @slide2
        @channel.set_as_default
      end

      it "should delete the second to last slide from default channel" do
        slide_count = @channel.slides.size  
        @slide.destroy
        @channel.slides.size.should == slide_count - 1
      end

      it "should not delete the last slide from the default channel" do
        slide_count = @channel.slides.size
        @slide.destroy
        @channel.slides.size.should == slide_count - 1
        expect { @slide2.destroy }.to raise_error(OnlySlideInDefaultChannelDeletionException)
        @slide2.deleted_at.should be_nil
        @channel.slides.size.should == slide_count - 1
      end
    end    
  end

end

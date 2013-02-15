require 'spec_helper'

describe "Channel" do
  describe "creation" do
    it "should create new channel" do
      channel = Channel.create!(name: "foo")
      channel.reload
      channel.name.should == "foo"
    end
    it "should not be created with name nil" do
      channel = Channel.new(name: nil)
      channel.should_not be_valid
      channel.errors[:name].should_not be_nil
    end
    it "should not be created with too short name" do
      channel = Channel.new(name: "s")
      channel.should_not be_valid
      channel.errors[:name].should_not be_nil
    end
    it "should not be created with too long name" do
      channel = Channel.new(name: "l" * 101)
      channel.should_not be_valid
      channel.errors[:name].should_not be_nil
    end
  end

  describe "deletion" do
    it "should set deleted_at timestamp when destroyed" do
      channel = Channel.new(name: "foo")
      channel.save
      channel.destroy
      channel.should be_valid
      channel.deleted_at.should_not be_nil
    end

    it "should not list deleted channels" do
      Channel.create!(name: "foo1")
      Channel.create!(name: "foo2")
      channel = Channel.create!(name: "foo3")
      count1 = Channel.count
      channel.destroy
      Channel.count.should == count1-1
    end

    it "should delete all channel relations on deletion" do
      slide = Slide.create!(name: "foo")
      slide2 = Slide.create!(name: "foo2")
      channel = Channel.create!(name: "ch")
      channel.slides << slide
      channel.slides << slide2
      channel.destroy
      channel.slides.size.should == 0
    end
  end

  describe "default method" do
    before do
      @default_channel = Channel.create!(name: "default")
      @non_default_channel = Channel.create!(name: "nondefault")
      slide = Slide.create!(name: "testslide")
      @default_channel.slides << slide
      @default_channel.set_as_default
    end

    it "should return true if the channel is the default 
      channel" do
      @default_channel.default?.should == true
    end

    it "should return false if the channel is not the default 
      channel" do
      @non_default_channel.default?.should == false
    end

    it "should not be able to destroy the default channel" do
      expect { @default_channel.destroy }.to raise_error(DestroyingDefaultChannelException)
    end

    it "should not be able to assign an empty channel as default" do
      expect { @non_default_channel.set_as_default }.to raise_error(EmptyDefaultChannelException)
    end

  end
end

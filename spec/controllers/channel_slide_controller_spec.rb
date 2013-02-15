require 'spec_helper'

describe ChannelSlidesController do
  before :each do
    @channel = Channel.create!(name:"Test channel")
    @slide = Slide.create!(name:"First slide")
    @channel.slides << @slide
    @channel_slide = @channel.channel_slides.first
  end

  describe "Slide listing" do
    it "Show all slides" do
      get :index, {channel_id: @channel.id}
      assigns(:channel_slides).should eq(@channel.channel_slides)
    end
  end
  
  describe "creation" do
    it "should be able to add slide to channel by json" do
      lambda {
        post :create, {channel_id: @channel.id, slide_id: @slide.id, format: :json}
      }.should change(ChannelSlide, :count).by(1)
      response.should be_success
    end
    it "should be able to add slide to channel by html" do
      lambda {
        post :create, {channel_id: @channel.id, slide_id: @slide.id, format: :html}
      }.should change(ChannelSlide, :count).by(1)
      response.status.should == 302
    end
  end
  
  describe "deletion" do
    it "should be able to delete slide from channel by json" do
      lambda {
        post :destroy, {channel_id: @channel.id, id: @channel_slide.id, format: :json}
      }.should change(ChannelSlide, :count).by(-1)
      response.status.should == 204
    end

    it "should be able to delete slide from channel by html" do
      lambda {
        post :destroy, {channel_id: @channel.id, id: @channel_slide.id, format: :html}
      }.should change(ChannelSlide, :count).by(-1)
      response.status.should == 302
    end

    it "should return 404 if channel_slide is not found" do
      lambda {
        post :destroy, {channel_id: @channel.id, id: -1, format: :html}
      }.should change(ChannelSlide, :count).by(0)
      response.status.should == 404
    end
  end

  describe "update" do
    it "should update the position" do
      slide2 = Slide.create!(name:"Second slide")
      @channel.slides << slide2
      channel_slide2 = @channel.channel_slides[1]

      put :update, {id: @channel_slide.id, channel_id: @channel.id, channel_slide: {position: 2}}, format: :html
      @channel_slide.reload
      @channel_slide.position.should == 2
      channel_slide2.reload
      channel_slide2.position.should == 1
    end

    it "should not update if nil position given" do
      put :update, {id: @channel_slide.id, channel_id: @channel.id, channel_slide: {position: "no_strings_allowed"}}, format: :html
      @channel_slide.position.should == 1
    end
  end
end

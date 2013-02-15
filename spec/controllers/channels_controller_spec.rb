require 'spec_helper'

describe ChannelsController do

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end
  end

  describe "Channel creation" do
    it "should be able to create channel by json" do
      lambda {
        post :create, channel: { name: "Foobar" }, format: :json
      }.should change(Channel, :count).by(1)
      response.should be_success
      body = MultiJson.decode(response.body)
      body["name"].should eq("Foobar")
    end

    it "should be able to create channel by html" do
      lambda {
        post :create, channel: { name: "Foobar" }, format: :html
      }.should change(Channel, :count).by(1)
      response.status.should == 302
    end

    it "should not accept zero-length names" do
      lambda {
        post :create, channel: { name: "" }, format: :json
      }.should change(Channel, :count).by(0)
      response.status.should == 400
    end
  end

  describe "Channel listing" do
    before :each do
      3.times do
        Channel.create!(name: "Foobar")
      end
      @channels = Channel.all
    end

    it "response should be successful" do
      get :index
      response.should be_success
    end

    it "should assign all the channels" do
      get :index
      assigns(:channels).should eq(@channels)
    end

    it "should return 5 channels" do
      6.times do
        Channel.create!(name: "TestChannel")
      end
      get :index, limit: 5, format: :json
      response.should be_success
      assigns[:channels].count.should == 5
    end

    it "should return 4 on second page" do
      6.times do
        Channel.create!(name: "TestChannel")
      end
      get :index,limit: 5, page: 2, format: :json
      response.should be_success
      assigns[:channels].count.should == 4
    end

    it "should return 0" do
      get :index,limit: 5, page: 2, format: :json
      response.should be_success
      assigns[:channels].count.should == 0
    end
  end

  describe "Show channel" do
    before :each do
      @channel = Channel.create!(name: "Testi")
    end

    it "should assign the correct channel" do
      get :show, id: @channel
      assigns(:channel).should eq(@channel)
      response.should be_success
    end

    it "should render the #show view" do
      get :show, id: @channel
      response.should render_template :show
      response.should be_success
    end
  end

  describe "Watch channel" do
    before :each do
      @channel = Channel.create!(name: "Test Channel")
      @slide = Slide.create!(name: "Test slide")
      @slide2 = Slide.create!(name: "Test slide 2")
      @channel.slides << @slide
      @channel.slides << @slide2
    end

    it "should assign the correct channel" do
      get :watch, id: @channel
      assigns(:channel).should eq(@channel)
      response.should be_success
    end

    it "should render the #watch view" do
      get :watch, id: @channel
      response.should render_template :watch
      response.should be_success
    end
  end

  describe "Retrieve next slide" do
    before :each do
      @channel = Channel.create!(name: "Test Channel")
      @slide = Slide.create!(name: "Test slide")
      @slide2 = Slide.create!(name: "Test slide 2")
      @channel.slides << @slide
      @channel.slides << @slide2
    end

    it "should assign the correct channel" do
      get :next_slide, :format => :json, id: @channel
      assigns(:channel).should eq(@channel)
      response.should be_success
    end

    it "should show the first slide" do
      get :next_slide, :format => :json, id: @channel
      assigns(:current_slide).should eq(@slide)
      response.should be_success
    end

    it "should show the second slide when current slide of the session is the first slide" do
      session[:current_slide] = 0
      get :next_slide, :format => :json, id: @channel
      assigns(:current_slide).should eq(@slide2)
      response.should be_success
    end

    it "should update last slide of client if client ID is set in cookie" do
      @client = Client.new
      @client.last_channel = @channel.id
      @client.last_slide = 12345
      @client.save
      cookies[:client_id] = @client.id 
      get :next_slide, :format => :json, id: @channel
      @client.reload
      @client.last_slide.should_not eq(12345)
      response.should be_success
      @client.destroy
    end
  end

  describe "Channel editing" do
    before :each do
      @channel = Channel.create!(name: "test_channel")
    end

    it "should render show view when update fails with html" do
      put :update, id: @channel, channel: {name: ""}, format: :html
      @channel.reload
      @channel.name.should == "test_channel"
      response.should render_template :show
    end

    it "should render show view when update is ok html" do
      put :update, id: @channel, channel: {name: "new_name"}, format: :html
      @channel.reload
      @channel.name.should == "new_name"
      response.should render_template :show
    end

    it "should return 400 when update fails with json" do
      put :update, id: @channel, channel: {name: ""}, format: :json
      @channel.reload
      @channel.name.should == "test_channel"
      response.status.should == 400
    end

    it "should be success when update is ok with json" do
      put :update, id: @channel, channel: {name: "new_name"}, format: :json
      @channel.reload
      @channel.name.should == "new_name"
      response.should be_success
    end
  end

  describe "Default channel" do
    before :each do
      @channel = Channel.create!(name: "Testi")
      slide = Slide.create!(name:"testi")
      @channel.slides << slide
    end

    it "should assign the default channel" do
      put :set_as_default, id: @channel
      @channel.default?.should == true
    end

    it "should not set a channel without slides as the default channel" do
      @channel.slides.clear
      put :set_as_default, id: @channel, format: :json
      response.status.should == 400
      body = MultiJson.decode(response.body)
      body["message"].should eq("Cannot set empty channel as default")
      @channel.reload.default?.should == false
    end
  end

  describe "Delete channel" do
    before :each do
      @channel = Channel.create!(name: "test_channel")
      @default_slide = Slide.create!(name:"default_slide")
      @channel.slides << @default_slide
    end

    it "should destroy the channel by json and return 204" do
      lambda {
        delete :destroy, id: @channel, format: :json
      }.should change(Channel, :count).by(-1)
      response.status.should == 204
    end

    it "should destroy the channel by html and redirect to dashboard" do
      lambda {
        delete :destroy, id: @channel, format: :html
      }.should change(Channel, :count).by(-1)
      response.should redirect_to(:controller => 'dashboard', :action => 'home')
    end

    it "should not delete the default channel and return 400" do
      @channel.set_as_default
      lambda {
        delete :destroy, id: @channel, format: :json
      }.should change(Channel, :count).by(0)
      response.status.should == 400
      body = MultiJson.decode(response.body)
      body["message"].should eq("The default channel cannot be destroyed")
    end

    it "should not delete the default channel and return 400 with html" do
      @channel.set_as_default
      lambda {
        delete :destroy, id: @channel, format: :html
      }.should change(Channel, :count).by(0)
      response.status.should == 400
      body = response.body
      body.should eq("The default channel cannot be destroyed")
    end
  end

  describe "Get default channel" do
    it "should find the default channel" do
      channel = Channel.create!(name: "Test")
      slide = Slide.create!(name:"test")
      channel.slides << slide
      put :set_as_default, id: channel
      Channel.find_default_channel.should eq(channel)
    end
  end
end

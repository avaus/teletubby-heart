require 'spec_helper'

describe ClientController do

    before :each do
      @default_channel = Channel.create!(name: "Test Default Channel")
      @slide = Slide.create!(name: "Test slide")
      @slide2 = Slide.create!(name: "Test slide 2")
      @default_channel.slides << @slide << @slide2
      @default_channel.set_as_default

      @other_channel = Channel.create!(name: "Test channel")
      @slide3 = Slide.create!(name: "Test slide 3")
      @slide4 = Slide.create!(name: "Test slide 4")
      @other_channel.slides << @slide3 << @slide4

      cookies[:client_id] = nil
    end

  describe "Client listing" do
    before :each do
      3.times do
        Client.create!
      end
      @clients = Client.find(:all, :order => "id")
    end

    it "response should be successful" do
      get :index
      response.should be_success
    end

    it "should list all the clients ordered by ID" do
      get :list
      assigns(:clients).should eq(@clients)
    end

  end
  
  describe "Channel switching" do
    
    before :each do
      @client = Client.new
      @client.last_channel = 1
      @client.last_slide = 10
      @client.save
    end

    it "should change the channel to the given channel" do
      put :switch_channel, id: @client.id, client: {last_channel: @other_channel.id}, format: html
      @client.reload
      @client.last_channel.should eq(@other_channel.id)
    end

    it "should set the last slide to 0" do
      put :switch_channel, id: @client.id, client: {last_channel: @other_channel.id}, format: html
      @client.reload
      @client.last_slide.should eq(0)
    end
  end

  describe "Client handshake" do
    it "should be able to get client page" do
      get :index
      response.should be_success
    end

    it "should create a new client if cookie doesn't contain ID and it should have default channel assigned" do
      get :index
      client = assigns[:client]
      client.should be_valid
      client.last_channel.should eq(@default_channel.id)
      response.should be_success
    end

    it "should use existing client if cookie contains ID" do
      client = Client.new
      client.last_channel = @other_channel.id
      client.last_slide = 0
      client.save
      cookies[:client_id] = client.id
      get :index
      assigns[:client].should eq(client)
      response.should be_success
    end

    it "should create a new client if the id in the cookie does not match a client in the database" do
      cookies[:client_id] = -1
      get :index
      client = assigns[:client]
      client.should be_valid
      client.last_channel.should eq(@default_channel.id)
      response.should be_success
    end

    it "should have valid time as last login" do
      get :index
      client = assigns[:client]
      client.last_login.should_not be_nil
      response.should be_success
    end
  end

  describe "Client removal" do
    before :each do
      3.times do
        client = Client.create!
        client.last_slide_change = Time.now - 1000
        client.save
      end
      @client = Client.create!
    end

    it "should be able to remove a single client" do
      lambda {
        delete :destroy, id: @client, format: :json
      }.should change(Client, :count).by(-1)
      response.status.should == 204
    end
    
    it "should be able to remove all inactive client" do
      lambda {
        delete :destroy_inactive_clients, id: @client, format: :json
      }.should change(Client, :count).by(-3)
      response.status.should == 204
    end
  end

end

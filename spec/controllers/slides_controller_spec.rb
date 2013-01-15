require 'spec_helper'

describe SlidesController do
  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end
  end

  describe "creation" do
    it "should be able to create by json" do
      lambda {
        post :create, slide: { type: "UrlSlide", name: "Foobar", url: "http://www.example.com" }, format: :json
      }.should change(Slide, :count).by(1)
      response.should be_success
      body = MultiJson.decode(response.body)
      body["name"].should eq("Foobar")
    end

    it "should be able to create by html" do
      lambda {
        post :create, slide: { type: "UrlSlide", name: "Foobar", url: "http://www.example.com" }, format: :html
      }.should change(Slide, :count).by(1)
      response.status.should == 302
    end

    it "should not accept slides without type" do
      lambda {
        post :create, slide: { name: "Foobar" }, format: :json
      }.should change(Slide, :count).by(0)
      response.status.should == 400
    end

    it "should not accept zero-length names" do
      lambda {
        post :create, slide: { type: "UrlSlide", name: "" }, format: :json
      }.should change(Slide, :count).by(0)
      response.status.should == 400
    end
  end

  describe "Slide listing" do
    before :each do
      3.times do
        Slide.create!(name: "Foobar")
      end
      @slides = Slide.all
    end

    it "response should be successful" do
      get :index
      response.should be_success
    end

    it "should assign all the slides" do
      get :index
      assigns(:slides).should eq(@slides)
    end
  end

  describe "Show slide" do
    before :each do
      @slide = UrlSlide.create!(name: "Testi")
    end

    it "should assign the correct slide" do
      get :show, id: @slide
      assigns(:slide).should eq(@slide)
      response.should be_success
    end

    it "should render the #show view" do
      get :show, id: @slide
      response.should render_template :show
      response.should be_success
    end
  end

  describe "Slide editing" do
    before :each do
      @slide = UrlSlide.create!(name: "test_slide")
    end

    it "should render edit view when update fails with html" do
      put :update, id: @slide, slide: {name: "", type: "UrlSlide"}, format: :html
      @slide.reload
      @slide.name.should == "test_slide"
      response.should render_template :show
    end

    it "should render edit view when update is ok html" do
      put :update, id: @slide, slide: {name: "new_name", type: "UrlSlide"}, format: :html
      @slide.reload
      @slide.name.should == "new_name"
      response.should render_template :show
    end

    it "should return 400 when update fails with json" do
      put :update, id: @slide, slide: {name: "", type: "UrlSlide"}, format: :json
      @slide.reload
      @slide.name.should == "test_slide"
      response.status.should == 400
    end

    it "should be success when update is ok with json" do
      put :update, id: @slide, slide: {name: "new_name", type: "UrlSlide"}, format: :json
      @slide.reload
      @slide.name.should == "new_name"
      response.should be_success
    end
  end

describe "Delete slide" do
    before :each do
      @slide = UrlSlide.create!(name: "test_slide")
      @channel = Channel.create!(name: "channel")
      @channel.slides << @slide
    end

    it "should destroy the slide by json and return 204" do
      lambda {
        delete :destroy, id: @slide, format: :json
      }.should change(Slide, :count).by(-1)
      response.status.should == 204
    end

    it "should not delete the last slide from default channel and return 400 with json" do
      @channel.set_as_default
      lambda {
        delete :destroy, id: @slide, format: :json
      }.should change(Slide, :count).by(0)
      response.status.should == 400
      body = MultiJson.decode(response.body)
      body["message"].should eq("OnlySlideInDefaultChannelDeletionException")
    end

  end

end

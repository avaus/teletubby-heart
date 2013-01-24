describe ApplicationHelper do
  describe "#absolute_asset_path" do
    before :each do
      helper.request = ActionController::TestRequest.new
      helper.request.stub(:host_with_port).and_return("www.example.com:8000")
    end

    it "should have full url to the asset" do
      helper.absolute_asset_path('public/slide.css').should eq("http://www.example.com:8000/assets/public/slide.css")
    end
  end
end
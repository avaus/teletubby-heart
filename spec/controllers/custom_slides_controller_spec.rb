describe CustomSlidesController do
  it "should return 200 #show" do
    @custom_slide = CustomSlide.create!(name: "testi", content: "<p>testi</p>", style: "/assets/templates/default.css")
    visit "/custom_slide/#{@custom_slide.id}"
    response.status.should eql(200)
    response.should render_template "custom_slides/show"
  end
end
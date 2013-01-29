class CustomSlidesController < ApplicationController
  layout false

  def show
    @custom_slide = Slide.find(params[:id])
  end
end
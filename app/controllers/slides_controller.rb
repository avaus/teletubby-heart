class SlidesController < ApplicationController
  def new
    @slide = Slide.new
  end

  def create
    model = params[:slide].delete(:type).constantize
    @slide = model.new(params[:slide])
    if @slide.save
      respond_to do |format|
        format.html { redirect_to slide_url(@slide) }
        format.json { render json: @slide.to_json }
      end
    else
      respond_to do |format|
        format.html { render action: :new }
        format.json { render status: 400, json: @slide.errors }
      end
    end
  rescue => e
    render_exception(Exception.new("Invalid slide type"))
  end

  respond_to :json, :html
  def index
    @slides = Slide.all
    respond_with(@slides)
  end

  respond_to :json, :html
  def show
    @slide = Slide.find(params[:id])
    respond_with(@slide)
  end

  def update
    @slide = UrlSlide.find(params[:id])
    if @slide.update_attributes(params[:slide].select { |k, _| k != :type })
      flash[:notice] = t(:slide_updated)
      respond_to do |format|
        format.html { render action: :show }
        format.json { render json: @slide.to_json }
      end
    else
      respond_to do |format|
        format.html { render action: :show }
        format.json { render status: 400, json: @slide.errors }
      end
    end
  end

  def update_type_selection
    model = params[:type].constantize
    @slide = model.new()
    if params[:type] == "UrlSlide"  then
      render :partial => "url_slide"
    elsif params[:type] == "ImageSlide" then
      render :partial => "image_slide"
    end
  end

  respond_to :json, :html
  def destroy
    @slide = Slide.find(params[:id])
    @slide.destroy
    respond_to do |format|
      format.json { render status: 204, json: nil }
    end
  rescue OnlySlideInDefaultChannelDeletionException => e
    render_exception(e)
  end
end

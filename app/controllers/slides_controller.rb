class SlidesController < ApplicationController
  def new
    @slide = Slide.new
    @channel_redirect_id = params[:channel]
  end

  def create
    @channel_redirect_id = params[:slide].delete(:channel_redirect_id)
    model = params[:slide].delete(:type).constantize
    @slide = model.new(params[:slide])
    if @slide.save
      flash[:notice] = t(:slide_created)
      respond_to do |format|
        format.html {
          if @channel_redirect_id.length > 0
            redirect_to channel_url(Channel.find(@channel_redirect_id))
          else
            redirect_to slide_url(@slide)
          end
        }
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
    model = params[:slide][:type].constantize
    @slide = model.find(params[:id])
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
    elsif params[:type] == "YoutubeSlide" then
      render :partial => "youtube_slide"
    elsif params[:type] == "CustomSlide" then
      render :partial => "custom_slide"
    end
  end

  respond_to :json, :html
  def destroy
    @slide = Slide.find(params[:id])
    @slide.destroy
    respond_to do |format|
      format.html { redirect_to controller: 'dashboard', action: 'home' }
      format.json { render status: 204, json: nil }
    end
  rescue OnlySlideInDefaultChannelDeletionException => e
    render_exception(e)
  end
end

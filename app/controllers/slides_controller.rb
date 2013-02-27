class SlidesController < ApplicationController
  def new
    @channel_redirect_id = getChannelRedirect
    if params.has_key?("type")
      model = params[:type].constantize
      @slide = model.new()
      @slide.type = params[:type]
    else
      @slide = Slide.new
      @slide.type = "UrlSlide"
    end
  end

  def create
    @channel_redirect_id = getChannelRedirect
    model = params[:slide].delete(:type).constantize
    @slide = model.new(params[:slide])
    if @slide.save
      respond_to do |format|
        format.html {
          if @channel_redirect_id
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
  rescue NameError => e
    render_exception(InvalidTypeException.new())
  end

  respond_to :json, :html
  def index
    @slides = Slide.all
    respond_with(@slides)
  end

  respond_to :json, :html
  def show
    @channel_redirect_id = getChannelRedirect
    @slide = Slide.find(params[:id])
    respond_with(@slide)
  end

  def update
    @channel_redirect_id = getChannelRedirect
    model = params[:slide].delete(:type).constantize
    @slide = model.find(params[:id])
    if @slide.update_attributes(params[:slide].select { |k, _| k != :type })
      respond_to do |format|
        format.html {
          if @channel_redirect_id
            redirect_to channel_url(Channel.find(@channel_redirect_id))
          else
            render action: :show
          end
        }
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
    @slide.name = params[:name]
    @slide.duration = params[:duration]
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
    @channel_redirect_id = getChannelRedirect
    @slide = Slide.find(params[:id])
    @slide.destroy
    respond_to do |format|
      format.html {
          if @channel_redirect_id
            redirect_to channel_url(Channel.find(@channel_redirect_id))
          else
            redirect_to controller: 'dashboard', action: 'home'
          end
        }
      format.json { render status: 204, json: nil }
    end
  rescue OnlySlideInDefaultChannelDeletionException => e
    render_exception(e)
  end

  def getChannelRedirect
    redirect_id = ""
    if params.has_key?("channel_redirect_id")
      redirect_id = params[:channel_redirect_id]
    end
    if params.has_key?("channel")
      redirect_id = params[:channel]
    end
    if redirect_id != ""
      return redirect_id
    else
      return false
    end
  end

end

class InvalidTypeException < StandardError
  def message
    "Invalid slide type"
  end
end
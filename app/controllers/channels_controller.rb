class ChannelsController < ApplicationController
  layout "client", :only => [:watch, :next_slide]

  def new
    @channel = Channel.new
  end

  def create
    @channel = Channel.new(params[:channel])
    if @channel.save
      respond_to do |format|
        format.html { redirect_to channel_url(@channel) }
        format.json { render json: @channel.to_json }
      end
    else
      respond_to do |format|
        format.html { render :new }
        format.json { render status: 400, json: @channel.errors }
      end
    end
  end

  respond_to :json, :html
  def index
    if params[:limit]
      @channels = Channel.page(params[:page]).per(params[:limit])
    else
      @channels = Channel.all
    end
    respond_to do |format|
        format.html { }
        format.json { render json: @channels }
    end
  end

  def update
    @channel = Channel.find(params[:id])
    if @channel.update_attributes(params[:channel])
      flash[:notice] = t(:channel_updated)
      respond_to do |format|
        format.html { render action: :show }
        format.json { render json: @channel.to_json }
      end
    else
      respond_to do |format|
        format.html { render action: :show }
        format.json { render status: 400, json: @channel.errors }
      end
    end
  end

  respond_to :json, :html
  def destroy
    @channel = Channel.find(params[:id])
    @channel.destroy
    respond_to do |format|
      format.html { redirect_to controller: 'dashboard', action: 'home' }
      format.json { render status: 204, json: nil }
    end
  rescue DestroyingDefaultChannelException => e
    render_exception(e)
  end

  def show
    @channel = Channel.find(params[:id])
  end

  def watch
    @channel = Channel.find(params[:id])
    session[:current_slide] = 0
    @current_slide = @channel.channel_slides[session[:current_slide]].slide
  end

  respond_to :json
  def next_slide
    @channel = Channel.find(params[:id])
    if session[:current_slide] == nil || session[:current_slide] > @channel.channel_slides.length - 2
      session[:current_slide] = 0
    else
      session[:current_slide] = session[:current_slide] + 1
    end
    @current_slide = @channel.channel_slides[session[:current_slide]].slide

    unless cookies[:client_id].nil?
      client = Client.find(cookies[:client_id])
      client.last_slide = session[:current_slide]
      client.last_slide_change = Time.now #we need to do this if there is a client looping the same slide all over again
      client.save
    end
    respond_with(@current_slide.to_json(methods: ['type'])) #Virtual attributes need to be added explicitly
  end

  respond_to :json, :html
  def set_as_default
    @channel = Channel.find(params[:id])
    @channel.set_as_default
    respond_to do |format|
      format.html { redirect_to controller: 'dashboard', action: 'home' }
      format.json { render json: @channel.to_json }
    end
  rescue EmptyDefaultChannelException => e
    render_exception(e)
  end
end

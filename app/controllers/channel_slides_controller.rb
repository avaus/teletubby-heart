class ChannelSlidesController < ApplicationController

  respond_to :json, :html
  def index
    @channel = Channel.find(params[:channel_id])
    @channel_slides = @channel.channel_slides
    respond_to do |format|
      format.html { }
      format.json { render json: @channel_slides }
    end
  end

  def create
    @channel = Channel.find(params[:channel_id])
    slide = Slide.find(params[:slide_id])
    @channel_slide = ChannelSlide.new
    @channel_slide.channel = @channel
    @channel_slide.slide = slide
    @channel_slide.save!
    respond_to do |format|
      format.html { redirect_to channel_url(@channel) }
      format.json { render json: @channel_slide }
    end
  end

  def destroy
    channel_slide = ChannelSlide.find(params[:id]).destroy
    respond_to do |format|
      format.html { redirect_to channel_url(channel_slide.channel) }
      format.json { render status: 204, json: nil }
    end
  end

  def update
    @channel_slide = ChannelSlide.find(params[:id])
    position_ok = update_position(@channel_slide, params[:channel_slide].delete(:position))
    @channel_slide.update_attributes(params[:channel_slide])
    if position_ok && @channel_slide.save
      respond_to do |format|
        format.html { redirect_to channel_url(@channel_slide.channel) }
        format.json { render json: @channel_slide }
      end
    else
      respond_to do |format|
        format.html { redirect_to channel_url(@channel_slide.channel) }
        format.json { render status: 400, json: @channel_slide.errors }
      end
    end
  end

  private
  def update_position(channel_slide, position)
    return true if position.blank?
    if position.to_i > 0
      channel_slide.set_list_position(position)
      return true
    else
      return false
    end
  end
end

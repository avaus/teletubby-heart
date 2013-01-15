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
    @channel_slide = ChannelSlide.find(params[:id]) #löytää väärän
    position_ok = update_positions(@channel_slide, params[:new_position])
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

  def update_positions(channel_slide, new_position)
    channel_slides = ChannelSlide.where(channel_id: channel_slide.channel_id)
    old_position = channel_slide.position.to_i
    new_position = new_position.to_i+1

    channel_slides.each do |channel_slide|
      position = channel_slide.position
      if new_position > old_position
        if position > old_position and position <= new_position
          channel_slide.update_attribute(:position, channel_slide.position-1)
        end
      else
        if position < old_position and position >= new_position
          channel_slide.update_attribute(:position, channel_slide.position+1)
        end
      end
    end
    channel_slide.update_attributes(position: new_position)
    return true
  end

end

class ClientController < ApplicationController

  layout "application", :only => :list

  def index

    if cookies[:client_id] == nil || !Client.exists?(cookies[:client_id])
      @client = Client.new
      @client.last_channel = Settings.default_channel_id
      @client.last_slide = 0
    else
      @client = Client.find(cookies[:client_id])
    end
    @client.last_login = Time.now
    @client.last_slide_change = Time.now
    @client.save
    cookies.permanent[:client_id] = @client.id

    @channel = Channel.find(@client.last_channel)
    @slide = @channel.channel_slides[@client.last_slide].slide
    session[:current_slide] = @client.last_slide
  end

  respond_to :json, :html
  def list
    @clients = Client.find(:all, :order => "id")
    @channels = Channel.all
    respond_to do |format|
        format.html { }
        format.json { render json: @clients }
    end
  end 

  def switch_channel
    @client = Client.find(params[:id])
    channel = params[:client][:last_channel]
    @client.last_channel = channel
    @client.last_slide = 0
    @client.save
    PrivatePub.publish_to("/clients/#{@client.id}","document.channelId = #{channel};")
    redirect_to :controller=>'client', :action => 'list'
  end

end

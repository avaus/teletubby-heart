class DashboardController < ApplicationController
  @@channels_per_page = 4
  def home
    if params[:page]
      @page = Integer(params[:page])
    else
      @page = 1
    end
    @pagination_next = false
    @pagination_prev = false
    @channels = Channel.page(@page).per(@@channels_per_page)
    if Channel.page(@page+1).per(@@channels_per_page).count > 0
      @pagination_next = true
    end
    if @page > 1
      @pagination_prev = true
    end
  end

  def about
  end

  def help
  end
end

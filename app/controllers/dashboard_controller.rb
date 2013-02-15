class DashboardController < ApplicationController
  def home
    @channels = Channel.page(params[:page]).per(4)
    if Channel.page(next_page()).per(4).count == 0
      @is_last = true
    end
  end

  def about
  end

  def help
  end
end

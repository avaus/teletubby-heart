class ChannelSlide < ActiveRecord::Base
  belongs_to :channel
  belongs_to :slide
  acts_as_list :scope => :channel

  validates_presence_of :channel
  validates_presence_of :slide
  def destroy
    if channel.default? == true
      if channel.slides.size == 1
        raise OnlySlideInDefaultChannelDeletionException
      end
    end
    super  
  end

end

class OnlySlideInDefaultChannelDeletionException < StandardError
end
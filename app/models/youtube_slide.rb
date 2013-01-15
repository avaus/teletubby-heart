class YoutubeSlide < Slide
  attr_accessible :youtube
  validates :youtube, presence: true

  def url
    return "http://www.youtube.com/embed/#{self.youtube}?enablejsapi=1&autoplay=1"
  end

  def self.model_name
    Slide.model_name
  end
end
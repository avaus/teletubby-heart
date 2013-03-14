class YoutubeSlide < Slide
  attr_accessible :youtube
  validates :youtube, presence: true

  def parse_youtube url
   	regex = /^(?:http(s)?:\/\/)?(?:www\.)?\w*\.\w*\/(?:watch\?v=)?((?:p\/)?[\w\-]+)/
   	url.match(regex)[2]
  end

  def url
    return "http://www.youtube.com/embed/#{self.parse_youtube(self.youtube)}?enablejsapi=1&autoplay=1"
  end

  def self.model_name
    Slide.model_name
  end
end
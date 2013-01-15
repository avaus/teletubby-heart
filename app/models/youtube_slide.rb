class YoutubeSlide < Slide
  attr_accessible :youtube
  validates :youtube , presence: true

  def url
    return self.youtube
  end

  def self.model_name
    Slide.model_name
  end
end
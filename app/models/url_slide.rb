class UrlSlide < Slide
  attr_accessible :url
  validates :url, presence: true

  def self.model_name
    Slide.model_name
  end
end
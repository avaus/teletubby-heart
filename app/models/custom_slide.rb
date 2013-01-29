class CustomSlide < Slide
  attr_accessible :content, :style
  validates :content, presence: true
  validates :style, presence: true



  def self.model_name
    Slide.model_name
  end

  def url
    return "/custom_slide/#{self.id}"
  end
end
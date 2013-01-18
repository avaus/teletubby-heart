class CustomSlide < Slide
  attr_accessible :content
  validates :content, presence: true


  def self.model_name
    Slide.model_name
  end

end
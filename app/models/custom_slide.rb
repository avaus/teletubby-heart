class CustomSlide < Slide
  attr_accessible :content
  validates :content, presence: true

end
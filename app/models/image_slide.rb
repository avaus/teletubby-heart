class ImageSlide < Slide
  attr_accessible :image
  has_attached_file :image
  validates_attachment :image, presence: true

  def self.model_name
    Slide.model_name
  end
end
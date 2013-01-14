class ImageSlide < Slide
  attr_accessible :image, :url
  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }
  validates_attachment :image, presence: true

  def url
    return self.image.url
  end

  def self.model_name
    Slide.model_name
  end
end
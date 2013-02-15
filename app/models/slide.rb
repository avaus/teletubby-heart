class Slide < ActiveRecord::Base
  default_scope where("deleted_at IS NULL")
  attr_accessible :name, :type, :duration
  attr_protected :deleted_at

  has_many :channel_slides
  has_many :channels, through: :channel_slides

  validates :name, presence: true
  validates :name, length: { maximum: 100, minimum: 2 }

  def destroy
    channel_slides.destroy_all
    self.deleted_at = Time.now
    save
  end

end

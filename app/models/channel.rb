class Channel < ActiveRecord::Base
  default_scope where("deleted_at IS NULL")
  attr_accessible :name
  attr_protected :deleted_at
  has_many :channel_slides, :order => "position"
  has_many :slides, through: :channel_slides

  validates :name, presence: true
  validates :name, length: { maximum: 100, minimum: 2 }

  def default?
    return Settings.default_channel_id == id
  end

  def ensure_not_default
    if default?
      raise DestroyingDefaultChannelException
    end
  end

  def self.find_default_channel
    return Channel.find(Settings.default_channel_id)
  end

  def destroy
    ensure_not_default
    channel_slides.destroy_all
    self.deleted_at = Time.now
    save
  end

  def set_as_default
    if slides.size == 0
      raise EmptyDefaultChannelException
    end
    Settings.default_channel_id = id
  end

  def as_json(options = { })
    super((options || { }).merge({
        methods: [:default?]
    }))
  end

end

class DestroyingDefaultChannelException < StandardError
  def message
    "The default channel cannot be destroyed"
  end
end

class EmptyDefaultChannelException < StandardError
  def message
    "Cannot set empty channel as default"
  end
end
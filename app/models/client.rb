class Client < ActiveRecord::Base
  attr_accessible :last_channel, :last_login, :last_slide, :last_slide_change, :user_agent
  attr_protected :deleted_at

  before_create :set_last_slide_change_to_now
  def set_last_slide_change_to_now
    self.last_slide_change = Time.now
  end

  INACTIVE = 300
  def active?
    return Time.now - self[:last_slide_change].localtime < INACTIVE
  end

  def destroy
    self.deleted_at = Time.now
    save
  end

end

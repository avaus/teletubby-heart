class Client < ActiveRecord::Base
  attr_accessible :last_channel, :last_login, :last_slide, :last_slide_change
  attr_protected :deleted_at
  INACTIVE = 300

  def active?
    return Time.now - self[:last_slide_change].localtime < INACTIVE
  end

  def destroy
    self.deleted_at = Time.now
    save
  end

end

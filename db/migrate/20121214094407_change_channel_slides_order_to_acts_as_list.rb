class ChangeChannelSlidesOrderToActsAsList < ActiveRecord::Migration
  def change
    rename_column :channel_slides, :order, :position
  end
end

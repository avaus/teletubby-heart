class AddDeletedAtToChannels < ActiveRecord::Migration
  def change
    add_column :channels, :deleted_at, :timestamp
  end
end

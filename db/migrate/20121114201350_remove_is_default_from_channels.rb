class RemoveIsDefaultFromChannels < ActiveRecord::Migration
  def up
    remove_column :channels, :is_default
  end

  def down
    add_column :channels, :is_default, :string
  end
end

class AddLastSlideChangeToClients < ActiveRecord::Migration
  def change
    add_column :clients, :last_slide_change, :datetime, :null => false, :default => Time.now
  end
end

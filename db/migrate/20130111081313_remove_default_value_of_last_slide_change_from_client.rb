class RemoveDefaultValueOfLastSlideChangeFromClient < ActiveRecord::Migration
  def up
    change_column_default(:clients, :last_slide_change, nil)
  end

  def down
    change_column_default(:clients, :last_slide_change, Time.now)
  end
end

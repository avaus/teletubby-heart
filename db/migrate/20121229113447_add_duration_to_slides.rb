class AddDurationToSlides < ActiveRecord::Migration
  def change
    add_column :slides, :duration, :integer, default: 10
  end
end

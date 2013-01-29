class AddStyleToSlide < ActiveRecord::Migration
  def change
    add_column :slides, :style, :string
  end
end

class AddYoutubeToSlides < ActiveRecord::Migration
  def change
    add_column :slides, :youtube, :text, default: "Youtube id"
  end
end

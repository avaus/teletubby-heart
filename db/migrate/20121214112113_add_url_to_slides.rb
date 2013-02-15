class AddUrlToSlides < ActiveRecord::Migration
  def change
    add_column :slides, :url, :text, default: "UrlSlide"
  end
end

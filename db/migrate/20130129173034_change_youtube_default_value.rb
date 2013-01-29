class ChangeYoutubeDefaultValue < ActiveRecord::Migration
  def change
    change_column :slides, :youtube, :text, default: "Youtube url"
  end
end

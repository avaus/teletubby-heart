class CreateChannelSlides < ActiveRecord::Migration
  def change
    create_table :channel_slides do |t|
      t.references :channel
      t.references :slide
      t.integer :order

      t.timestamps
    end
    add_index :channel_slides, :channel_id
    add_index :channel_slides, :slide_id
  end
end

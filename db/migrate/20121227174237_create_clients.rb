class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.integer :last_channel
      t.integer :last_slide
      t.datetime :last_login
      t.datetime :deleted_at

      t.timestamps
    end
  end
end

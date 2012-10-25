class CreateChannels < ActiveRecord::Migration
  def change
    create_table :channels do |t|
      t.string :name
      t.string :crawl_link
      t.integer :channel_num
      t.timestamps
    end
  end
end

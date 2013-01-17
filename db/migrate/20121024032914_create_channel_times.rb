class CreateChannelTimes < ActiveRecord::Migration
  def change
    create_table :channel_times do |t|
      t.integer :channel_id
      t.text :time
      t.string :date
      t.timestamps
    end
  end
end

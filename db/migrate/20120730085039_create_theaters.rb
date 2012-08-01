class CreateTheaters < ActiveRecord::Migration
  def change
    create_table :theaters do |t|

      t.string :name
      t.boolean  :is_second_round, :default => false
      t.string :location
      t.timestamps
    end
  end
end

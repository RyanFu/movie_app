class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|

      t.string   :name
      t.string   :name_en
      t.text     :intro
      t.string   :poster_url
      t.string   :release_date
      t.string   :running_time
      t.string   :level_url
      t.string   :actors
      t.string   :directors
      t.boolean  :is_first_round, :default => false
      t.boolean  :is_second_round, :default => false

      t.timestamps
    end
  end
end

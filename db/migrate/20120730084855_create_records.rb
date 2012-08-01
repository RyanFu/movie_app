class CreateRecords < ActiveRecord::Migration
  def change
    create_table :records do |t|

      t.string :comment
      t.integer :score
      t.integer :movie_id
      t.integer :user_id

      t.timestamps
    end
    add_index :records, :movie_id
    add_index :records, :user_id
  end
end

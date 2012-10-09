class CreatePttData < ActiveRecord::Migration
  def change
    create_table :ptt_data do |t|
      t.string :ptt_user_id
      t.string :title
      t.string :link
      t.string :content

      t.integer :score
      t.integer :movie_id
      
      t.timestamps
    end
  end
end

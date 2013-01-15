class CreateCampaigns < ActiveRecord::Migration
  def change
    create_table :campaigns do |t|
      t.string :picture_out
  	  t.string :picture_in
      t.string :title
      t.text   :description
      t.datetime :time_active
      t.text :measure
      t.string :teach_pic
      t.string :award_condition
      t.string :award
      t.string :award_pic
      t.text :precaution
      t.integer :movie_id
      t.string :award_list
      t.integer :is_show
      t.timestamps
    end
  end
end

class CreateAppprojects < ActiveRecord::Migration
  def change
    create_table :appprojects do |t|
      t.string :name
      t.string :iconurl
      t.string :pack
      t.string :clas
      t.string :promo_title
      t.string :content 
      t.timestamps
    end
  end
end

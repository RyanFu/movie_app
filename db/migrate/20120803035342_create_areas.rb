class CreateAreas < ActiveRecord::Migration
  def change
    create_table :areas do |t|
      t.string :name
      t.timestamps
    end
    add_column :theaters, :area_id, :integer
    add_index :theaters, :area_id
  end
end

class Ggg < ActiveRecord::Migration
  def change
    add_column :movies, :actors_str, :string
    add_column :movies, :directors_str, :string
  end
end

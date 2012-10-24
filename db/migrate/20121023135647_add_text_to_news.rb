class AddTextToNews < ActiveRecord::Migration
  def change
    add_column :news, :text, :text
  end
end

class AddLinkToTheater < ActiveRecord::Migration
  def change
    add_column :theaters, :link, :string
  end
end

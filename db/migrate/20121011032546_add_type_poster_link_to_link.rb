class AddTypePosterLinkToLink < ActiveRecord::Migration
  def change
    add_column :news, :picture_url, :string
    add_column :news, :news_type, :integer
  end
end

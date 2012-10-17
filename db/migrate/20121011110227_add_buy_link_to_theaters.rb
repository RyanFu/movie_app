class AddBuyLinkToTheaters < ActiveRecord::Migration
  def change
    add_column :theaters, :buy_link, :string
  end
end

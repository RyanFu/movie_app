class AddPhoneToTheaters < ActiveRecord::Migration
  def change
    add_column :theaters, :phone, :string
  end
end

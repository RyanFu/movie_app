class ChangeCommentToText < ActiveRecord::Migration
  def up
    change_column :records, :comment, :text
    change_column :comments, :text, :text
  end

  def down
    change_column :records, :comment, :string
    change_column :comments, :text, :string
  end
end

class AddCommentCountLoveCountToRecord < ActiveRecord::Migration
  def change
    add_column :records, :comments_count, :integer, :default => 0
    Record.find_each do |record|
      record.update_attribute(:comments_count, record.comments.length)
      record.save
    end
    add_column :records, :love_count, :integer, :default => 0
  end
end

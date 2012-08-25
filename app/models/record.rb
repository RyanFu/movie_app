class Record < ActiveRecord::Base
  belongs_to :movie
  belongs_to :user
  has_many :comments
  has_many :streams
  
  attr_accessible :comment,:score, :movie_id, :user_id
  scope :friend_records, lambda { |user| where('user_id in (?)', user.friends) if user.friends.size > 0 }
  scope :by_updated, order('updated_at DESC')
  scope :by_id, order('id ASC')
end

class Stream < ActiveRecord::Base
  belongs_to :user
  belongs_to :record
  belongs_to :comment
  belongs_to :movie
  belongs_to :stream_user, :class_name => "User", :foreign_key => "stream_user_id"

  scope :by_id, order('id DESC')
  scope :user_streams, lambda { |user| where('user_id in (?)', user) }
end

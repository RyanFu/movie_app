class Stream < ActiveRecord::Base
  belongs_to :user
  belongs_to :record
  belongs_to :comment
  scope :by_id, order('id DESC')
end

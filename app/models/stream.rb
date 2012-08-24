class Stream < ActiveRecord::Base
  belongs_to :user
  belongs_to :record
  belongs_to :comment
  default_scope :order => 'created_at DESC'
end

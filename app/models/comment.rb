class Comment < ActiveRecord::Base
  attr_accessible :record_id, :user_id, :text
  belongs_to :record
  belongs_to :user
  has_many :streams, :dependent => :delete_all
end

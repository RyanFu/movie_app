class UserLoveRecordShip < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :user
  belongs_to :record, :counter_cache => :love_count
end

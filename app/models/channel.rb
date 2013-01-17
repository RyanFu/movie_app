class Channel < ActiveRecord::Base
  # attr_accessible :title, :body
  has_many :channel_times
end

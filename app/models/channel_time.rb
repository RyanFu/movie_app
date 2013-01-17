class ChannelTime < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :channel
end

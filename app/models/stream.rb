class Stream < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :user
  belongs_to :record
  belongs_to :comment
end

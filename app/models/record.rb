class Record < ActiveRecord::Base
  belongs_to :movie
  belongs_to :user

  attr_accessible :comment,:score, :movie_id, :user_id
end

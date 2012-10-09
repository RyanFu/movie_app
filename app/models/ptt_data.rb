class PttData < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :ptt_user_id, :title, :link, :content, :score, :movie_id

end

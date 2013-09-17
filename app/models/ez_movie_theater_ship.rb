class EzMovieTheaterShip < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :movie
  belongs_to :theater
  belongs_to :area
  
end

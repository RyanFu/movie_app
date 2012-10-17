class MovieTheaterShip < ActiveRecord::Base
  belongs_to :movie
  belongs_to :theater
  belongs_to :area
end

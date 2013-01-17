class MovieTheaterShip < ActiveRecord::Base
  belongs_to :movie
  belongs_to :theater
  belongs_to :area

  scope :timetable_use, select('movie_id, theater_id, area_id, timetable, hall_type')
end

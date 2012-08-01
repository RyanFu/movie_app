class Theater < ActiveRecord::Base
  has_many :movies
  attr_accessible :name,:location

  has_many :movie_theater_ships
  has_many :on_view_movies, :through => :movie_theater_ships, :source => :movie
end

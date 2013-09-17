class Theater < ActiveRecord::Base
  belongs_to :area

  attr_accessible :name,:location

  has_many :movie_theater_ships
  has_many :on_view_movies, :through => :movie_theater_ships, :source => :movie

  has_many :ez_movie_theater_ships
  has_many :on_view_movies, :through => :ez_movie_theater_ships, :source => :movie
end

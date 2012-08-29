class MovieBoxOfficeShip < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :movie

  def self.hot_movies
    movies = []
    self.all.each do |b|
      movies << b.movie
    end
    movies
  end
end

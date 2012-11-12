# encoding: utf-8
class MovieBoxOfficeShipCrawl
  include Crawler

  def fetch
    @page_url = "http://tw.movies.yahoo.com/chart.html?cate=taipei"
    @page_html = get_page(@page_url)
    
  end

  def parse_first_movie
    nodes = @page_html.css(".first .c3 .text a")
    movie_name = nodes[1].text.strip
    movie = Movie.find_by_name_en(movie_name)
    ship = MovieBoxOfficeShip.new
    ship.movie = movie
    ship.save
  end
  
  def parse_box_office
    nodes = @page_html.css(".c3 a")
    (2..nodes.size/2-1).each do |i|
      movie_name = nodes[i*2].text.strip
      movie = Movie.find_by_name(movie_name)
      puts movie_name if movie
      unless movie
        movie_en_name = nodes[i*2+1].text.strip
        movie = Movie.find_by_name_en(movie_en_name) unless movie_en_name == ""
        (puts movie_en_name) if movie
      end
      unless movie
        movies = Movie.where(["name like ?", "%#{movie_name[movie_name.length-5..movie_name.length-1]}%"])
        movie = movies[0] if movies
        (movie) ? (puts movie_name) : (puts "errors happen")
      end
      if movie
        ship = MovieBoxOfficeShip.new
        ship.movie = movie
        ship.save
      end
    end
  end
end

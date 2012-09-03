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
      movie_name = nodes[i*2+1].text.strip
      puts movie_name
      movie = Movie.find_by_name_en(movie_name)
      unless movie
        movie_name = nodes[i*2].text.strip
        movie = Movie.find_by_name(movie_name)
      end
      ship = MovieBoxOfficeShip.new
      ship.movie = movie
      ship.save
    end
  end
end

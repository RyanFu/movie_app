# encoding: utf-8
class MovieTheaterShipCrawl
  include Crawler

  def parse_first_round_movie
    crawler = MovieTheaterShipCrawl.new

    nodes = @page_html.css(".only_text span a")
    nodes.each do |item|
      if (item.text.strip == "戲院時刻")
        url = "http://www.atmovies.com.tw/" +item[:href]
        crawler.fetch url
        crawler.parse_relation_ship
      end
    end
  end

  def parse_second_round_movie
    crawler = MovieTheaterShipCrawl.new

    nodes = @page_html.css(".only_text .row-1 .col-3 a")
    nodes.each do |item|
      if (item.text.strip == "戲院時刻")
        url = "http://www.atmovies.com.tw/" +item[:href]
        crawler.fetch url
        crawler.parse_relation_ship
      end
    end
  end

  def parse_relation_ship
    movie_name_en = @page_html.css(".at12b_gray").text.strip
    movie = Movie.find_by_name_en(movie_name_en)
    return unless movie
    nodes = @page_html.css('.row-1_2 a')
    
    nodes.each do |item|
      puts "parse theater :"+item.text.strip
      t = Theater.find_by_name(item.text.strip)
      if t==nil
        puts item.text.strip[2..item.text.strip.length] + "影城"
        t = Theater.find_by_name(item.text.strip[2..item.text.strip.length] + "影城")
      end

      # puts "    Theater name : " + t.name
      t.on_view_movies << movie unless t.on_view_movies.include? movie
      puts "movie name: " + movie.name + "    Theater name : " + t.name
    end
  end
  
end

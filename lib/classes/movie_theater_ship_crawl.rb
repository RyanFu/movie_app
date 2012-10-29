# encoding: utf-8
class MovieTheaterShipCrawl
  include Crawler

  def parse_theater_movie
    nodes = @page_html.css(".group tbody tr td a")

    nodes.each do |node|
      puts "theater name: " + node.text.strip
      theater = Theater.find_by_name(node.text.strip)

      next if [469,534,464,468,528].include? theater.id
      url = node[:href]
      crawl = MovieTheaterShipCrawl.new
      crawl.fetch url
      puts url
      crawl.parse_movie theater
    end
  end

  def parse_movie theater
    nodes = @page_html.css(".row-container .item .text")
    is_second_round = theater.is_second_round
    nodes.each do |node|
      movie_name = node.css("h4")
      movie = Movie.find_by_name(movie_name.text.strip)
      
      puts "movie name :" + movie.name

      movie.is_second_round = is_second_round if is_second_round
      movie.is_first_round = true unless is_second_round
      movie.save

      timetable_nodes = node.css(".mtcontainer span.tmt")
      times = timetable_nodes.map{|node| node.text.strip}
      timetable = times.join("|")
      puts timetable


      ship = MovieTheaterShip.new
      ship.movie= movie
      ship.theater = theater
      ship.timetable = timetable
      ship.area = theater.area
      ship.save

    end
  end

  # def parse_first_round_movie
  #   crawler = MovieTheaterShipCrawl.new

  #   nodes = @page_html.css(".only_text span a")
  #   nodes.each do |item|
  #     if (item.text.strip == "戲院時刻")
  #       url = "http://www.atmovies.com.tw/" +item[:href]
  #       crawler.fetch url
  #       crawler.parse_relation_ship
  #     end
  #   end
  # end

  # def parse_second_round_movie
  #   crawler = MovieTheaterShipCrawl.new

  #   nodes = @page_html.css(".only_text .row-1 .col-3 a")
  #   nodes.each do |item|
  #     if (item.text.strip == "戲院時刻")
  #       url = "http://www.atmovies.com.tw/" +item[:href]
  #       crawler.fetch url
  #       crawler.parse_relation_ship
  #     end
  #   end
  # end

  # def parse_relation_ship
  #   movie_name_en = @page_html.css(".at12b_gray").text.strip
  #   movie = Movie.find_by_name_en(movie_name_en)
  #   unless movie
  #     movie_name = @page_html.css(".at21b").text.strip
  #     movie = Movie.find_by_name(movie_name)
  #   end
  #   return unless movie
  #   nodes = @page_html.css('.row-1_2 a')
    
  #   nodes.each do |item|
  #     puts "parse theater :"+item.text.strip
  #     t = Theater.find_by_name(item.text.strip)
  #     if t==nil
  #       puts item.text.strip[2..item.text.strip.length] + "影城"
  #       t = Theater.find_by_name(item.text.strip[2..item.text.strip.length] + "影城")
  #     end
  #     if t==nil
  #       t = Theater.find_by_name(item.text.strip + "影城")
  #     end

  #     return if t==nil

  #     # puts "    Theater name : " + t.name
  #     t.on_view_movies << movie unless t.on_view_movies.include? movie
  #     puts "movie name: " + movie.name + "    Theater name : " + t.name
  #   end
  # end
  
end

# encoding: utf-8
class MovieTheaterShipCrawl
  include Crawler

  def parse_theater_movie
    nodes = @page_html.css(".group tbody tr td a")

    nodes.each do |node|
      # puts "theater name: " + node.text.strip
      theater = Theater.find_by_name(node.text.strip)
      puts "do not find the theater #{theater}XXXXXXXXXXXDDDDDDDDDDD" unless theater
      next unless theater
      next if [469,534,464,528].include? theater.id
      url = node[:href]
      crawl = MovieTheaterShipCrawl.new
      crawl.fetch url
      # puts url
      crawl.parse_movie(theater)
    end
  end

  def parse_movie theater
    
    theater_nodes = @page_html.css(".bd-container .text h4")
    # puts theater_nodes[0].text
    phone = theater_nodes[0].text
    phone = phone[3..phone.size]
    theater_finded_by_phone = Theater.find_by_phone phone
    # puts "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$yes yes yes finded by phone number " if theater_finded_by_phone
    theater = theater_finded_by_phone if theater_finded_by_phone

    nodes = @page_html.css(".row-container .item .text")
    is_second_round = theater.is_second_round
    nodes.each do |node|
      movie_name = node.css("h4")
      movie = Movie.find_by_name(movie_name.text.strip)

      unless movie
        movie_name = movie_name.text.strip
        movies = Movie.where(["name like ?", "%#{movie_name[movie_name.length-5..movie_name.length-1]}%"])
        movie = movies[0] if movies
        puts "Theater : #{theater.name} #{theater.id}"
        (movie) ? (puts "Movie name :#{movie_name}, finded movie_name : #{movie.name} #{movie.id}") : (puts "Movie name :#{movie_name} errors happen")
      end
      puts "XXXXXXXXXXXXXX    Theater : #{theater.name}   Movie name : #{movie_name}　XXXXXXXXXXXXXXXXXXXXX" unless movie
      next unless movie


      # puts "movie name :" + movie.name

      movie.is_second_round = is_second_round if is_second_round
      movie.is_first_round = true unless is_second_round
      movie.save

      timetable_nodes = node.css(".mtcontainer span.tmt")
      times = timetable_nodes.map{|node| node.text.strip}
      timetable = times.join("|")
      # puts timetable
      
      hall_type_nodes = node.css(".mvtype img")
      if hall_type_nodes.size > 0
        hall_types = hall_type_nodes.map{|node| node[:src]}
        hall_type = hall_types.join("***")
        # puts hall_type
      end

      ship = MovieTheaterShip.new
      ship.movie= movie
      ship.theater = theater
      ship.timetable = timetable
      ship.area = theater.area
      ship.hall_type = hall_type
      ship.save

    end
  end

  def second_round_movie theater
    nodes = @page_html.css("#theater_showtime .showtime_block .showtime_box")
    nodes.each do |node|
      name = node.css(".film_title a").text.strip
      movie = Movie.find_by_name(name)
      
      unless movie
        movies = Movie.where(["name like ?", "%#{name[name.length-4..name.length-1]}%"])
        movie = movies[0] if movies
        puts "Theater : #{theater.name} #{theater.id}"
        (movie) ? (puts "Movie name :#{name}, finded movie_name : #{movie.name} #{movie.id}") : (puts "Movie name :#{name} errors happen")
      end

      # unless movie
      #   crawler = MovieCrawler.new
      #   node_a = node.css(".film_title a")
      #   url = "http://www.atmovies.com.tw/movie/" + node_a[0][:href]
      #   crawler.fetch url
      #   crawler.parse_all
      #   movie = crawler.save_to_movie({:is_second_round=>true})
      # end

      unless movie
        next
      end

      movie.is_second_round = true
      movie.save
      
      lis = node.css(".showtime_area li")
      timetable = lis.map{|li| li.text}
      timetable = timetable.join("|")
      ship = MovieTheaterShip.new
      ship.movie= movie
      ship.theater = theater
      ship.timetable = timetable
      ship.area = theater.area
      ship.save
    end

  end
  
end

# encoding: utf-8
class MovieTheaterShipCrawl
  include Crawler


  def parse_theater_from_atmovies theater
    nodes = @page_html.css("#theater_showtime .showtime_block .showtime_box")
    nodes.each do |node|
      name = node.css(".film_title a").text.strip
      movie = Movie.find_by_name(name)

      if name == ("暮光之城：破曉Ⅱ")
        movie = Movie.find(2458)
        puts ("xxxxx   movie 暮光之城：破曉Ⅱ")
      end
      
      unless movie
        movies = Movie.where(["name like ?", "%#{name[name.length-4..name.length-1]}%"])
        movie = movies[0] if movies
        puts "Theater : #{theater.name} #{theater.id}"
        (movie) ? (puts "Movie name :#{name}, finded movie_name : #{movie.name} #{movie.id}") : (puts "Movie name :#{name} errors happen")
      end

      unless movie
        movies = Movie.where(["name like ?", "%#{name[0..4]}%"])
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

      (theater.is_second_round) ? (movie.is_second_round = true) : (movie.is_first_round = true)

      ezding_theaters = [445, 441, 450, 448, 465, 454, 455, 456, 477, 486, 487, 494, 495, 500, 497, 514, 519, 520, 537]

      movie.is_ezding = true if ezding_theaters.include? theater.id

      movie.save
      
      type = node.css(".showtime_area .version").text.strip

      lis = node.css(".showtime_area li")
      timetable = lis.map{|li| li.text.strip}
      timetable = timetable.map{|time| time = time[0..4]}
      timetable = timetable.join("|")
      ship = MovieTheaterShip.new
      ship.hall_type = parse_type(type)
      ship.hall_str = parse_hall_str(type)
      ship.movie= movie
      ship.theater_id = theater.id + parse_special_theater(type)
      ship.timetable = timetable
      ship.area = theater.area
      ship.save
    end
  end

  def parse_special_theater type
    i = 0
    i = 1 if type.index("M CLUB")
    i = 1 if type.index("VIP")
    i = 1 if type.index("Gold Class")
    i
  end

  def parse_hall_str type
    type_arr = type.split(" ")
    type_arr.map!{|item| item if item.index("廳")}
    type_arr.join(" ")
  end

  def parse_type type
    urls = [ "http://l.yimg.com/f/i/tw/movie/movietime_icon/icon_imax.gif",
             "http://l.yimg.com/f/i/tw/movie/movietime_icon/icon_3d.gif",
             "http://l.yimg.com/f/i/tw/movie/movietime_icon/icon_digital.gif",
             "http://l.yimg.com/f/i/tw/movie/movietime_icon/icon_chi.gif"]
    type_arr = []
    type_arr << urls[0] if type.index("IMAX")
    type_arr << urls[1] if type.index("3D")
    type_arr << urls[2] if type.index("數位")
    type_arr << urls[3] if type.index("國語")
    (type_arr.present?) ? ( type_str = type_arr.join("***") ) : nil 
  end

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
      timetable = lis.map{|li| li.text.strip}
      timetable = timetable.join("|")
      ship = MovieTheaterShip.new
      ship.movie= movie
      ship.theater = theater
      ship.timetable = timetable
      ship.area = theater.area
      ship.save
    end

  end

  def parse_theater_from_atmovies_v2 theater
    nodes = @page_html.css("#theater_showtime .showtime_block .showtime_box")
    nodes.each do |node|
      name = node.css(".film_title a").text.strip
      movie = Movie.find_by_name(name)

      if name == ("暮光之城：破曉Ⅱ")
        movie = Movie.find(2458)
        puts ("xxxxx   movie 暮光之城：破曉Ⅱ")
      end
      
      unless movie
        movies = Movie.where(["name like ?", "%#{name[name.length-4..name.length-1]}%"])
        movie = movies[0] if movies
        puts "Theater : #{theater.name} #{theater.id}"
        (movie) ? (puts "Movie name :#{name}, finded movie_name : #{movie.name} #{movie.id}") : (puts "Movie name :#{name} errors happen")
      end

      unless movie
        movies = Movie.where(["name like ?", "%#{name[0..4]}%"])
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

      (theater.is_second_round) ? (movie.is_second_round = true) : (movie.is_first_round = true)

      #ezding_theaters = [445, 441, 450, 448, 465, 454, 455, 456, 477, 486, 487, 494, 495, 500, 497, 514, 519, 520, 537]

      #movie.is_ezding = true if ezding_theaters.include? theater.id

      movie.save
      
      type = node.css(".showtime_area .version").text.strip

      lis = node.css(".showtime_area li")
      timetable = lis.map{|li| li.text.strip}
      timetable = timetable.map{|time| time = time[0..4]}
      #timetable = timetable.join("|")

      timetable.each do |timetab|

        ship = EzMovieTheaterShip.new
        ship.hall_type = parse_type(type)
        ship.hall_str = parse_hall_str(type)
        ship.movie= movie
        ship.theater_id = theater.id + parse_special_theater(type)
        ship.timetable = timetab
        ship.area = theater.area
        ship.session_showdate = Date.current
        ship.save
      end  
    end
  end

  def parse_type_v2 type
    urls = [ "http://pic.pimg.tw/jumplives/1379318849-2451702606.png",
             "http://pic.pimg.tw/jumplives/1379318788-52046045.png",
             "http://pic.pimg.tw/jumplives/1379318849-1865113158.png",
             "http://pic.pimg.tw/jumplives/1379318807-2400754944.png",
             "http://pic.pimg.tw/jumplives/1379318807-2400754944.png"]
    type_arr = []
    type_arr << urls[0] if type.index("IMAX")
    type_arr << urls[1] if type.index("3D")
    type_arr << urls[2] if type.index("數位")
    type_arr << urls[3] if type.index("國")
    type_arr << urls[4] if type.index("中文")
    (type_arr.present?) ? ( type_str = type_arr.join("***") ) : nil 
  end 

  def parse_hall_str_v2 type
    /\({1}(.*)\)/ =~ type
    hallstr = $1
    if hallstr == "MC中文版" or hallstr == "MC"
      "MC"
    elsif hallstr == nil
      $1
    elsif hallstr.index("廳")
      $1
    else
      type = ""
    end    
  end  

  def parse_theater_from_ezding ez_xml_doc
    cinemas = ez_xml_doc.css("Movie_Data Cinemas Cinema")
    cinemas.each do |cinema|
      theaterez_id = cinema.css("Cinema_ID").text
      theater = Theater.find_by_theaterez_id(theaterez_id)
      #p theater.name
      mnames = cinema.css("Movies Movie")
  
      mnames.each do |mname|
       # p "===="
        movieez_id = mname.css("Movie_ID").text
       # p movieez_id

        name =  mname.css("Movie_CName").text
        type = name

       # p name
        /(.*)\({1}/ =~ name
       # p $1
        movie_name = $1
        if $1 == nil
       #   p name
          movie_name =  name
        elsif $1 == ""
          /\){1}(.*)/ =~ name
        #  p "---"
        #  p $1
          movie_name = $1
        end 
        movie = Movie.find_by_name(movie_name)
       # p movie.id if movie != nil

        if movie_name == ("鬼夜迷離夜")
          movie = Movie.find(4747)
          puts ("xxxxx   movie 鬼夜迷離夜")
        end

        unless movie
          movies = Movie.where(["name like ?", "%#{movie_name[movie_name.length-4..movie_name.length-1]}%"])
          p movies[0].id if movies != [] 
        end

        unless movie
          next
        end
    
        ez_sessions = mname.css("Sessions Session")
    

      #  p "XXXXXXXXXXXXXXX"
      #  p type

      #  p parse_type_v2(type)
      #  p parse_hall_str_v2(type)

        ez_sessions.each do |ez_session|
        #  p ez_session.css("Session_ID").text
          session_id = ez_session.css("Session_ID").text
          showdatetime = ez_session.css("Session_Time").text
          d = DateTime.parse showdatetime
         # p "#################"
         # p "#{d.year}-#{d.month}-#{d.day}"
          session_showdate = "#{d.year}-#{d.month}-#{d.day}"
         # p "#{d.hour}：#{d.minute}"
          timetable = "#{d.hour}：#{d.minute}"
          ship = EzMovieTheaterShip.new
          ship.movie = movie
          ship.theater_id = theater.id
          ship.area = theater.area
          ship.hall_type = parse_type_v2(type)
          ship.hall_str = parse_hall_str_v2(type)
          ship.timetable = timetable
          ship.session_showdate = session_showdate
          ship.session_id = session_id
          ship.movieez_id = movieez_id
          ship.save
        end
      end
    end   
  end  
end

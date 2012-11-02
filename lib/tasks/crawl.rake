# encoding: utf-8
namespace :crawl do

  desc "Craw Website Item"

  task :fetch_channel => :environment do
    
    ChannelTime.all.each do |ct|
      ct.delete
    end


    dates = []
    (0..2).each do |i|
      dates << Time.now + i.days
    end

    dates.map{|date| date.strftime "%Y/%m/%d"}
    # dates = ["2012/10/24","2012/10/25","2012/10/26"]

    dates.each do |date|
      option = { 'date'=> date }
      Channel.all.each do |channel|
        url = channel.crawl_link
        mtcrawl = MovieTvCrawler.new
        mtcrawl.post_fetch(url,option)
        mtcrawl.parse_date
        mtcrawl.parse_time
        mtcrawl.save channel
      end
    end
  end

  task :fetch_theater => :environment do

    # Area.all.each do |a|
    #   a.delete
    # end
    
    # Theater.all.each do |t|
    #   t.delete
    # end

     url = "http://tw.movies.yahoo.com/theater_list.html"
     area_values = [0,3,18,16,1,20,15,2,22,19,13,21,10,17,11,12,9,14,23]

     t = TheaterCrawler.new
     area_values.each do |area_value|
      option = { 'area' => area_value }
      t.post_fetch(url,option)
      t.parse_theater
     end
  end
  
  ######## orginl form open eye but now not use

  # task :set_first_second_round_movie => :environment do
  #   Movie.all.each do |m|
  #     m.is_first_round = false
  #     m.is_second_round = false
  #     m.save
  #   end 
  #   d = DataCrawler.new
  #   d.get_first_round_movie
  #   d.get_second_round_movie
  # end

  task :build_movie_box_office_relation => :environment do

    Movie.hot.each do |m|
      m.is_hot = true
      m.save
    end

    MovieBoxOfficeShip.all.each do |m|
      m.delete
    end
    crawler = MovieBoxOfficeShipCrawl.new
    crawler.fetch
    crawler.parse_first_movie
    crawler.parse_box_office

    MovieBoxOfficeShip.hot_movies.each do |m|
      m.is_hot = true
      m.save
    end
  end

  task :parse_movie_time_and_theater_ship => :environment do
    Movie.update_all(:is_first_round => false)
    Movie.update_all(:is_second_round => false)

    MovieTheaterShip.all.each do |m|
      m.delete
    end

    url = "http://tw.movies.yahoo.com/theater_list.html"
    area_values = [0,3,18,16,1,20,15,2,22,19,13,21,10,17,11,12,9,14,23]

    t = MovieTheaterShipCrawl.new
    area_values.each do |area_value|
      option = { 'area' => area_value }
      t.post_fetch(url,option)
      t.parse_theater_movie
    end
    
    # 日新戲院統一廳 宜蘭　之後不會再出現？
    # url = "http://www.atmovies.com.tw/showtime/theater_t03904_a39.html"
    # theater = Theater.find(532)
    # ships  = theater.movie_theater_ships
    # ship = ships[0]
    # ship.movie_id = 4323
    # ship.save
    #南台　台南
    url = "http://www.atmovies.com.tw/showtime/theater_t06602_a06.html"
    crawl = MovieTheaterShipCrawl.new
    crawl.fetch url
    nodes = crawl.page_html.css("#theater_showtime .showtime_block .showtime_box")
    theater = Theater.find(540)
    nodes.each do |node|
      name = node.css(".film_title a").text.strip
      movie = Movie.find_by_name(name)
      
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

    #麻豆　台南
    url = "http://www.atmovies.com.tw/showtime/theater_t06625_a06.html"
    crawl = MovieTheaterShipCrawl.new
    crawl.fetch url
    nodes = crawl.page_html.css("#theater_showtime .showtime_block .showtime_box")
    theater = Theater.find(512)
    ships  = theater.movie_theater_ships
    ships.each do |ship|
      ship.delete
    end

    nodes.each do |node|
      name = node.css(".film_title a").text.strip
      movie = Movie.find_by_name(name)
      
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


    # urls ={
    #     "基隆"=>"http://www.atmovies.com.tw/showtime/area_a01.html",
    #     "台北"=>"http://www.atmovies.com.tw/showtime/area_a02.html",
    #     "桃園"=>"http://www.atmovies.com.tw/showtime/area_a03.html",
    #     "新竹"=>"http://www.atmovies.com.tw/showtime/area_a35.html",
    #     "苗粟"=>"http://www.atmovies.com.tw/showtime/area_a37.html",
    #     "台中"=>"http://www.atmovies.com.tw/showtime/area_a04.html",
    #     "彰化"=>"http://www.atmovies.com.tw/showtime/area_a47.html",
    #     "雲林"=>"http://www.atmovies.com.tw/showtime/area_a45.html",
    #     "南投"=>"http://www.atmovies.com.tw/showtime/area_a49.html",
    #     "嘉義"=>"http://www.atmovies.com.tw/showtime/area_a05.html",
    #     "台南"=>"http://www.atmovies.com.tw/showtime/area_a06.html",
    #     "高雄"=>"http://www.atmovies.com.tw/showtime/area_a07.html",
    #     "宜蘭"=>"http://www.atmovies.com.tw/showtime/area_a39.html",
    #     "花蓮"=>"http://www.atmovies.com.tw/showtime/area_a38.html",
    #     "台東"=>"http://www.atmovies.com.tw/showtime/area_a89.html",
    #     "屏東"=>"http://www.atmovies.com.tw/showtime/area_a87.html",
    #     "澎湖"=>"http://www.atmovies.com.tw/showtime/area_a69.html"
    #  }
    #  t = MovieTheaterShipCrawl.new
    #  urls.each do |local, url|
    #    t.fetch url
    #    t.parse_first_round_movie
    #    t.parse_second_round_movie
    #  end
  end

  task :reset_running_time => :environment do
    # m = Movie.first
    # puts m.running_time
    # puts m.running_time.index('分')
    # puts m.running_time[3..m.running_time.index('分')-1]
    (65..88).each do |i|
      m = Movie.find(i)
      m.running_time = m.running_time[3..m.running_time.index('分')-1]
      m.save
    end
  end

  task :crawl_yahoo_on_view => :environment do
    d = DataCrawler.new
    d.get_yahoo_on_view_movies
  end

  task :crawl_yahoo_dvd_movies => :environment do
    urls =[
        "http://tw.movie.yahoo.com/dvdgenre_result.html?g=1",
        "http://tw.movie.yahoo.com/dvdgenre_result.html?g=2",
        "http://tw.movie.yahoo.com/dvdgenre_result.html?g=3",
        "http://tw.movie.yahoo.com/dvdgenre_result.html?g=4",
        "http://tw.movie.yahoo.com/dvdgenre_result.html?g=5",
        "http://tw.movie.yahoo.com/dvdgenre_result.html?g=6",
        "http://tw.movie.yahoo.com/dvdgenre_result.html?g=7",
        "http://tw.movie.yahoo.com/dvdgenre_result.html?g=8",
        "http://tw.movie.yahoo.com/dvdgenre_result.html?g=9",
        "http://tw.movie.yahoo.com/dvdgenre_result.html?g=10",
        "http://tw.movie.yahoo.com/dvdgenre_result.html?g=11",
        "http://tw.movie.yahoo.com/dvdgenre_result.html?g=12",
        "http://tw.movie.yahoo.com/dvdgenre_result.html?g=13",
        "http://tw.movie.yahoo.com/dvdgenre_result.html?g=14",
        "http://tw.movie.yahoo.com/dvdgenre_result.html?g=15",
        "http://tw.movie.yahoo.com/dvdgenre_result.html?g=16",
        "http://tw.movie.yahoo.com/dvdgenre_result.html?g=17",
        "http://tw.movie.yahoo.com/dvdgenre_result.html?g=18"
    ]
    urls.each do |url|
      d = DataCrawler.new
      d.get_yahoo_dvd_movies url
    end
  end
  # task :set_first_second_round_movie => :environment do
  #   Movie.all.each do |m|
  #     m.is_first_round = false
  #     m.is_second_round = false
  #     m.save
  #   end 
  #   d = DataCrawler.new
  #   d.set_first_round_movie
  #   d.set_second_round_movie
  # end
  task :crawl_yahoo_comming_movies => :environment do
    
    Movie.comming.each do |m|
      m.is_comming = false
      m.save
    end

    urls =[
        "http://tw.movies.yahoo.com/movie_comingsoon.html?p=1",
        "http://tw.movies.yahoo.com/movie_comingsoon.html?p=2",
        "http://tw.movies.yahoo.com/movie_comingsoon.html?p=3",
        "http://tw.movies.yahoo.com/movie_comingsoon.html?p=4",
        "http://tw.movies.yahoo.com/movie_comingsoon.html?p=5"
    ]
    urls.each do |url|
      d = DataCrawler.new
      d.get_yahoo_comming_movies url
    end
  end
  task :crawl_yahoo_this_week_movies => :environment do
    Movie.this_week.each do |m|
      m.is_this_week = false
      m.save
    end
    d = DataCrawler.new
    d.get_yahoo_this_week_movie
  end
  task :crawl_all_yahoo_movies => :environment do
    d = DataCrawler.new
    d.get_yahoo_all_movies
  end
end

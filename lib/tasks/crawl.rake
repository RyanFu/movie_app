# encoding: utf-8
namespace :crawl do

  desc "Craw Website Item"

  task :fetch_theater => :environment do
     urls ={
        "基隆"=>"http://www.atmovies.com.tw/showtime/area_a01.html",
        "台北"=>"http://www.atmovies.com.tw/showtime/area_a02.html",
        "桃園"=>"http://www.atmovies.com.tw/showtime/area_a03.html",
        "新竹"=>"http://www.atmovies.com.tw/showtime/area_a35.html",
        "苗粟"=>"http://www.atmovies.com.tw/showtime/area_a37.html",
        "台中"=>"http://www.atmovies.com.tw/showtime/area_a04.html",
        "彰化"=>"http://www.atmovies.com.tw/showtime/area_a47.html",
        "雲林"=>"http://www.atmovies.com.tw/showtime/area_a45.html",
        "南投"=>"http://www.atmovies.com.tw/showtime/area_a49.html",
        "嘉義"=>"http://www.atmovies.com.tw/showtime/area_a05.html",
        "台南"=>"http://www.atmovies.com.tw/showtime/area_a06.html",
        "高雄"=>"http://www.atmovies.com.tw/showtime/area_a07.html",
        "宜蘭"=>"http://www.atmovies.com.tw/showtime/area_a39.html",
        "花蓮"=>"http://www.atmovies.com.tw/showtime/area_a38.html",
        "台東"=>"http://www.atmovies.com.tw/showtime/area_a89.html",
        "屏東"=>"http://www.atmovies.com.tw/showtime/area_a87.html",
        "澎湖"=>"http://www.atmovies.com.tw/showtime/area_a69.html"
     }
     t = TheaterCrawler.new
     urls.each do |local, url|
       t.fetch url
       t.parse_location
       t.parse_theater
       t.save_to_theater
     end
  end

  task :fetch_movies => :environment do
    Movie.all.each do |m|
      m.is_first_round = false
      m.is_second_round = false
      m.save
    end
    d = DataCrawler.new
    d.get_first_round_movie
    d.get_second_round_movie
  end

  task :build_movie_theater_relation => :environment do
    urls ={
        "基隆"=>"http://www.atmovies.com.tw/showtime/area_a01.html",
        "台北"=>"http://www.atmovies.com.tw/showtime/area_a02.html",
        "桃園"=>"http://www.atmovies.com.tw/showtime/area_a03.html",
        "新竹"=>"http://www.atmovies.com.tw/showtime/area_a35.html",
        "苗粟"=>"http://www.atmovies.com.tw/showtime/area_a37.html",
        "台中"=>"http://www.atmovies.com.tw/showtime/area_a04.html",
        "彰化"=>"http://www.atmovies.com.tw/showtime/area_a47.html",
        "雲林"=>"http://www.atmovies.com.tw/showtime/area_a45.html",
        "南投"=>"http://www.atmovies.com.tw/showtime/area_a49.html",
        "嘉義"=>"http://www.atmovies.com.tw/showtime/area_a05.html",
        "台南"=>"http://www.atmovies.com.tw/showtime/area_a06.html",
        "高雄"=>"http://www.atmovies.com.tw/showtime/area_a07.html",
        "宜蘭"=>"http://www.atmovies.com.tw/showtime/area_a39.html",
        "花蓮"=>"http://www.atmovies.com.tw/showtime/area_a38.html",
        "台東"=>"http://www.atmovies.com.tw/showtime/area_a89.html",
        "屏東"=>"http://www.atmovies.com.tw/showtime/area_a87.html",
        "澎湖"=>"http://www.atmovies.com.tw/showtime/area_a69.html"
     }
     t = MovieTheaterShipCrawl.new
     urls.each do |local, url|
       t.fetch url
       t.parse_first_round_movie
     end
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
end

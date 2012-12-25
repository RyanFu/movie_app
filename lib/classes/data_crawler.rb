# encoding: utf-8
class DataCrawler
  include Crawler
  
  # def get_first_round_movie
  #   fetch "http://www.atmovies.com.tw/movie/movie_now-0.html"
  #   nodes = @page_html.css(".listall a")
  #   nodes.each do |item|
  #     href = item[:href]
  #     url = "http://www.atmovies.com.tw/movie/" + href
  #     puts url
        
  #     begin
  #       m = MovieCrawler.new
  #       m.fetch url
  #       m.parse_all
  #       m.save_to_movie ({:is_first_round=>true})
  #     rescue
  #       puts ".........................crawl fail....................................."
  #       puts ".........................crawl fail....................................."
  #       puts ".........................crawl fail....................................."
  #       puts url
  #       puts ".........................crawl fail....................................."
  #       puts ".........................crawl fail....................................."
  #       puts ".........................crawl fail....................................."
  #     end
  #   end
  # end

  # def get_second_round_movie
  #   fetch "http://www.atmovies.com.tw/movie/movie_now2-0.html"
  #   nodes = @page_html.css(".listall a")
  #   nodes.each do |item|
  #     href = item[:href]
  #     url = "http://www.atmovies.com.tw/movie/" + href
  #     puts url
        
  #     begin
  #       m = MovieCrawler.new
  #       m.fetch url
  #       m.parse_all
  #       m.save_to_movie ({:is_second_round=>true})
  #     rescue
  #       puts ".........................crawl fail....................................."
  #       puts ".........................crawl fail....................................."
  #       puts ".........................crawl fail....................................."
  #       puts url
  #       puts ".........................crawl fail....................................."
  #       puts ".........................crawl fail....................................."
  #       puts ".........................crawl fail....................................."
  #     end
  #   end
  # end
  
  # yahoo 上映中電影
  def get_yahoo_on_view_movies url="http://tw.movie.yahoo.com/movie_intheaters.html"
    fetch url
    nodes = @page_html.css(".row-container .item .img a")
    nodes.each do |item|
      url = item[:href]
      puts url

      begin
        m = MovieCrawlerYahoo.new
        m.fetch url
        m.parse_all
        m.save_to_movie
      end
    end
    
    nodes = @page_html.css(".ymvpaging .n .pagelink")
    unless nodes.blank?
      url = "http://tw.movie.yahoo.com/movie_intheaters.html" + nodes[0][:href]
      data = DataCrawler.new
      data.get_yahoo_on_view_movies url
    end

  end

  def get_yahoo_all_movies 
    (4543..4551).each do |i|
      url = "http://tw.movie.yahoo.com/movieinfo_main.html/id=" + i.to_s
      begin
        m = MovieCrawlerYahoo.new
        m.fetch url
        m.parse_all
        m.save_to_movie
      rescue
        puts ".........................crawl fail....................................."
        puts ".........................crawl fail....................................."
        puts ".........................crawl fail....................................."
        puts url
        puts ".........................crawl fail....................................."
        puts ".........................crawl fail....................................."
        puts ".........................crawl fail....................................."
      end
    end
  end

  def get_yahoo_dvd_movies url
    fetch url
    nodes = @page_html.css(".row-container .item .img a")
    nodes.each do |item|
      url = item[:href]
      puts url

      begin
        m = MovieCrawlerYahoo.new
        m.fetch url
        m.parse_dvd_all
        m.save_to_movie
      rescue
        puts ".........................crawl fail....................................."
        puts ".........................crawl fail....................................."
        puts ".........................crawl fail....................................."
        puts ".........................crawl fail....................................."
        puts ".........................crawl fail....................................."
        puts ".........................crawl fail....................................."
      end
    end
    nodes = @page_html.css(".ymvpaging .n .pagelink")
    unless nodes.blank?
      url = "http://tw.movie.yahoo.com/dvdgenre_result.html" + nodes[0][:href]
      data = DataCrawler.new
      data.get_yahoo_dvd_movies url
    end
  end

  def set_first_round_movie
    fetch "http://www.atmovies.com.tw/movie/movie_now-0.html"
    nodes = @page_html.css(".listall a")
    nodes.each do |item|
      begin
        name = item.text.strip
        m = Movie.find_by_name name
        m.is_first_round = true
        m.save
      rescue
        puts item.text.strip
        puts "error"
      end
    end
  end

  def set_second_round_movie
    fetch "http://www.atmovies.com.tw/movie/movie_now2-0.html"
    nodes = @page_html.css(".listall a")
    nodes.each do |item|
      begin
        name = item.text.strip
        m = Movie.find_by_name name
        m.is_second_round = true
        m.save
      rescue
        puts item.text.strip
        puts "error"
      end
    end
  end

  def get_yahoo_comming_movies url
    fetch url
    nodes = @page_html.css(".row-container .item .img a")
    nodes.each do |item|
      url = item[:href]
      puts url

      begin
        m = MovieCrawlerYahoo.new
        m.fetch url
        m.parse_all
        m.save_to_movie ({:is_comming=>true})
      end
    end
  end

  def get_yahoo_this_week_movie
    url = "http://tw.movies.yahoo.com/movie_thisweek.html"
    fetch url
    nodes = @page_html.css(".row-container .item .img a")
    nodes.each do |item|
      url = item[:href]
      puts url

      begin
        m = MovieCrawlerYahoo.new
        m.fetch url
        m.parse_all
        m.save_to_movie ({:is_this_week => true})
      end
    end
  end 
end

# encoding: utf-8
class DataCrawler
  include Crawler
  
  def get_first_round_movie
    fetch "http://www.atmovies.com.tw/movie/movie_now-0.html"
    nodes = @page_html.css(".listall a")
    nodes.each do |item|
      href = item[:href]
      url = "http://www.atmovies.com.tw/movie/" + href
      puts url
        
      begin
        m = MovieCrawler.new
        m.fetch url
        m.parse_all
        m.save_to_movie ({:is_first_round=>true})
      rescue
        puts "error"
      end
    end
  end

  def get_second_round_movie
    fetch "http://www.atmovies.com.tw/movie/movie_now2-0.html"
    nodes = @page_html.css(".listall a")
    nodes.each do |item|
      href = item[:href]
      url = "http://www.atmovies.com.tw/movie/" + href
      puts url
        
      begin
        m = MovieCrawler.new
        m.fetch url
        m.parse_all
        m.save_to_movie ({:is_second_round=>true})
      rescue
      end
    end
  end
end

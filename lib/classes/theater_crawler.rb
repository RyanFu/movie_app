# encoding: utf-8
class TheaterCrawler
  include Crawler
  
  attr_accessor :names, :location

  def parse_location
    @location = @page_html.css("#title").text.strip
    puts @location
  end

  def parse_theater
    @names = @page_html.css(".only_text .row .col-1").text.strip.gsub("\t","").gsub("\n","").split("\r\r\r\r")
    puts @names
  end

  def save_to_theater
    @names.each do |name|
      theater = Theater.new(:name => name, :location => @location)
      theater.save
    end
  end
  
end

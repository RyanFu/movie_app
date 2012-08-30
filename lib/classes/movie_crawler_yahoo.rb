# encoding: utf-8
class MovieCrawlerYahoo
  include Crawler
  
  attr_accessor :movie_name, :movie_name_en, :movie_intro, :movie_poster_url, :movie_release_date, :movie_running_time, :movie_level_url, :movie_actors, :movie_directors

  def parse_name
    @movie_name = @page_html.css(".text.bulletin h4").text.strip
    puts @movie_name
    @movie_name_en = @page_html.css(".text.bulletin h5").text.strip
    puts @movie_name_en
  end

  def parse_level_url
    nodes = @page_html.css(".text.bulletin img.gate")
    nodes.each do |item|
      src = item[:src]
      @movie_level_url = src
    end

    puts @movie_level_url
  end

  def parse_intro
    nodes = @page_html.css(".bd-container .text.full")
    @movie_intro = nodes.first.text.strip
    puts @movie_intro
  end
  
  def parse_poster_url
    poster_url = @page_html.css(".img .border img")[0][:src]
    @movie_poster_url = poster_url.gsub("mpost2","mpost")
    puts @movie_poster_url
  end

  def parse_release_date_and_running_time
    str = @page_html.css(".text.bulletin .dta")[0].text
    @movie_release_date = str.gsub("-","/")
    @movie_running_time = @page_html.css(".text.bulletin .dta")[2].text

    puts @movie_release_date
    puts @movie_running_time
  end

  def parse_actors_and_directors
    director = @page_html.css(".text.bulletin .dta")[3].text
    directors_array = director.split(",")
    @movie_directors = directors_array
    
    actors_array = @page_html.css(".text.bulletin .dta")[4].text
    actors_array = actors_array.split(",")
    @movie_actors = actors_array

    puts @movie_directors
    puts @movie_actors
  end

  def parse_all
    parse_name
    parse_level_url
    parse_intro
    parse_poster_url
    parse_release_date_and_running_time
    parse_actors_and_directors
  end

  def save_to_movie(option={})
     


    movie = Movie.new(
      :name => @movie_name,
      :name_en => @movie_name_en,
      :intro => @movie_intro,
      :poster_url => @movie_poster_url,
      :release_date => @movie_release_date,
      :running_time => @movie_running_time,
      :level_url => @movie_level_url,
      :actors => @movie_actors,
      :directors => @movie_directors
    )
    movie = Movie.find_by_name(@movie_name) if Movie.find_by_name(@movie_name)
    option.each do |key, value|
      movie[key] = value
    end
    movie.save
  end
end

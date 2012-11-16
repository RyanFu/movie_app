# encoding: utf-8
class MovieCrawler
  include Crawler
  
  attr_accessor :movie_name, :movie_name_en, :movie_intro, :movie_poster_url, :movie_release_date, :movie_running_time, :movie_level_url, :movie_actors, :movie_directors

  def parse_name
    @movie_name = @page_html.css(".at21b").text.strip
    puts @movie_name
    @movie_name_en = @page_html.css(".at12b_gray").text.strip
    puts @movie_name_en
  end

  def parse_level_url
    nodes = @page_html.css(".title img")
    nodes.each do |item|
      src = item[:src]
      @movie_level_url = src if src.index('cer_')
    end

    puts @movie_level_url
  end

  def parse_intro
    nodes = @page_html.css(".sub_content")
    @movie_intro = nodes.first.text.strip
    puts @movie_intro
  end
  
  def parse_poster_url
    @movie_poster_url = @page_html.css("#movie_info01 .col-1 img")[0][:src]
    puts @movie_poster_url
  end

  def parse_release_date_and_running_time
    str = @page_html.css(".col-2 b").text
    str_split = str.split(" ")
    @movie_release_date = str_split[1]
    @movie_running_time = str_split[0]
    @movie_running_time = @movie_running_time[3..@movie_running_time.index('分')-1]

    puts @movie_release_date
    puts @movie_running_time
  end

  def parse_actors_and_directors
    nodes = @page_html.css(".crew_row table tr")
    directors_array = nodes[0].text.split(" ")
    directors_array.delete_at(0)
    @movie_directors = directors_array
    
    actors_array = nodes[1].text.split(" ")
    actors_array.delete_at(0)
    str = actors_array.last.chars.select{|i| i.valid_encoding?}.join
    actors_array[actors_array.size-1] = str

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
    if Movie.find_by_name(@movie_name) || Movie.find_by_name_en(@movie_name_en)
      movie = Movie.find_by_name(@movie_name) || Movie.find_by_name_en(@movie_name_en)
    end
    movie.save
    movie
    # if Movie.find_by_name(@movie_name) || Movie.find_by_name_en(@movie_name_en)
    #   movie = Movie.find_by_name(@movie_name)
    #   movie = Movie.find_by_name_en(@movie_name_en) unless movie
    #   option.each do |key, value|
    #     movie[key] = value
    #   end
    #   movie.release_date = @movie_release_date
    #   puts movie.name
    #   movie.save
    # else
    #   puts ".........................movie not find....................................."
    #   puts ".........................crawl fail....................................."
    #   puts ".........................crawl fail....................................."
    #   puts url
    #   puts ".........................crawl fail....................................."
    #   puts ".........................crawl fail....................................."
    #   puts ".........................crawl fail....................................." 
    # end
  end
end

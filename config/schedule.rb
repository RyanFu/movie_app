# encoding: utf-8
# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
env :PATH, ENV['PATH']

every 1.minute do
  rake 'crawl:print_time',:output => {:error => 'log/error.log', :standard => 'log/cron.log'}
end

every :day, :at => '00:01am' do  
  rake 'crawl:fetch_channel',:output => {:error => 'log/error.log', :standard => 'log/cron.log'}
end

every :day, :at => '00:11am' do  
  rake 'crawl:crawl_imdb_rating',:output => {:error => 'log/error.log', :standard => 'log/cron.log'}
end

every :day, :at => '04:00am' do  
  rake 'crawl:parse_movie_time_and_theater_ship_atmovies',:output => {:error => 'log/error.log', :standard => 'log/cron.log'}
end
every :day, :at => '04:30am' do  
  rake 'crawl:parse_movie_time_and_theater_ship_atmovies_v2',:output => {:error => 'log/error.log', :standard => 'log/cron.log'}
end
every :day, :at => '04:32am' do  
  rake 'crawl:parse_movie_time_and_theater_ship_ezdingxml',:output => {:error => 'log/error.log', :standard => 'log/cron.log'}
end

every :day, :at => '8:00am' do  
  rake 'crawl:parse_movie_time_and_theater_ship_atmovies',:output => {:error => 'log/error.log', :standard => 'log/cron.log'}
end
every :day, :at => '8:30am' do  
  rake 'crawl:parse_movie_time_and_theater_ship_atmovies_v2',:output => {:error => 'log/error.log', :standard => 'log/cron.log'}
end
every :day, :at => '8:32am' do  
  rake 'crawl:parse_movie_time_and_theater_ship_ezdingxml',:output => {:error => 'log/error.log', :standard => 'log/cron.log'}
end

every :day, :at => '03:00pm' do  
  rake 'crawl:parse_movie_time_and_theater_ship_atmovies',:output => {:error => 'log/error.log', :standard => 'log/cron.log'}
end
every :day, :at => '03:30pm' do  
  rake 'crawl:parse_movie_time_and_theater_ship_atmovies_v2',:output => {:error => 'log/error.log', :standard => 'log/cron.log'}
end
every :day, :at => '03:32pm' do  
  rake 'crawl:parse_movie_time_and_theater_ship_ezdingxml',:output => {:error => 'log/error.log', :standard => 'log/cron.log'}
end

every :day, :at => '05:01am' do
  rake 'user:update_user_friends_ship',:output => {:error => 'log/error.log', :standard => 'log/cron.log'}
end

every :thursday, :at => '02:00am' do
  rake 'crawl:crawl_yahoo_comming_movies',:output => {:error => 'log/error.log', :standard => 'log/cron.log'}
end

every :friday, :at => '08:00am' do
  rake 'crawl:crawl_yahoo_on_view',:output => {:error => 'log/error.log', :standard => 'log/cron.log'}
end

every :saturday, :at => '08:00am' do
  rake 'crawl:crawl_yahoo_on_view',:output => {:error => 'log/error.log', :standard => 'log/cron.log'}
end


every :monday, :at => '09:00am' do
  rake 'crawl:crawl_yahoo_this_week_movies',:output => {:error => 'log/error.log', :standard => 'log/cron.log'}
  rake 'crawl:crawl_yahoo_on_view',:output => {:error => 'log/error.log', :standard => 'log/cron.log'}
  rake 'crawl:crawl_yahoo_comming_movies',:output => {:error => 'log/error.log', :standard => 'log/cron.log'}
end

every :monday, :at => '05:30pm' do
  rake 'crawl:build_movie_box_office_relation',:output => {:error => 'log/error.log', :standard => 'log/cron.log'}
end


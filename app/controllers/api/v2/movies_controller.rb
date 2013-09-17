class Api::V2::MoviesController < ApplicationController
  def index
    movie_id = params[:movie_id]
    ships = EzMovieTheaterShip.where(:movie_id => movie_id).select('area_id').uniq


    response = []
    finresponse = []
    kresponse = []
    ships.each do |ship|
      n = {}
      n["Area"] = ship.area_id      
      showdates = EzMovieTheaterShip.where(:area_id => ship.area_id).select('session_showdate').uniq.order("session_showdate")

      showdates_ary = []
      showdates.each do |showdate|
        showdates_ary << showdate.session_showdate
      end	

      n["Date"] = showdates_ary
      response << n
    end
    
    nn = {}
    nn["AreaDate"] = response
    finresponse << nn

    
    movie_theater_ships = EzMovieTheaterShip.includes(:theater).where(:area_id => ships[0].area_id,:movie_id => movie_id,:session_showdate => Date.current).select('theater_id,timetable,session_id,hall_type,hall_str,movieez_id')

    temp = 0
    temp_hall_type = 0
    temp_hall_str = 0
    movie_theater_ships.each do |movie_theater_ship| 
      

      next if temp == movie_theater_ship.theater_id and temp_hall_type == movie_theater_ship.hall_type and temp_hall_str == movie_theater_ship.hall_str
      k = {}
      #還未判斷 非ezding -1
      k["ez_check_id"] = movie_theater_ship.theater.theaterez_id
      
      if movie_theater_ship.hall_type == [] and movie_theater_ship.hall_str == []
        time_sessions = movie_theater_ships.where(:theater_id => movie_theater_ship.theater_id,:hall_type => 'NULL',:hall_str=> 'NULL' )

      elsif movie_theater_ship.hall_type != [] and movie_theater_ship.hall_str == []
        time_sessions = movie_theater_ships.where(:theater_id => movie_theater_ship.theater_id,:hall_type => movie_theater_ship.hall_type,:hall_str=> 'NULL' )
      elsif movie_theater_ship.hall_type == [] and movie_theater_ship.hall_str != []
        time_sessions = movie_theater_ships.where(:theater_id => movie_theater_ship.theater_id,:hall_type => 'NULL',:hall_str=> movie_theater_ship.hall_str )
      else
        time_sessions = movie_theater_ships.where(:theater_id => movie_theater_ship.theater_id,:hall_type => movie_theater_ship.hall_type,:hall_str=> movie_theater_ship.hall_str )
      end  




      time_sessions_ary = [] 
      time_sessions.each do |time_session|
        t = {}
        t["time"] = time_session.timetable
        t["session_id"] = time_session.session_id
        time_sessions_ary << t
      end 

      k["timeTable"] = time_sessions_ary
      k["hall_type"] = movie_theater_ship.hall_type
      k["hall_str"] = movie_theater_ship.hall_str
      k["theater"] = movie_theater_ship.theater.name
      k["theater_id"] = movie_theater_ship.theater_id
      k["ez_movie_id"] = movie_theater_ship.movieez_id
      kresponse << k
      temp = movie_theater_ship.theater_id 
      temp_hall_type = movie_theater_ship.hall_type
      temp_hall_str = movie_theater_ship.hall_str

    end
    kk = {}
    kk["movie_theater_ship"] = kresponse
    finresponse << kk
   
    render :json => finresponse.to_json
  end
  
  def show
    area_id = params[:id]
    movie_id = params[:movie_id]
    session_showdate = params[:date]
    
    kresponse = []
    movie_theater_ships = EzMovieTheaterShip.includes(:theater).where(:area_id => area_id,:movie_id => movie_id,:session_showdate => session_showdate).select('theater_id,timetable,session_id,hall_type,hall_str,movieez_id')
    
    temp = 0
    temp_hall_type = 0
    temp_hall_str = 0
    movie_theater_ships.each do |movie_theater_ship| 
      next if temp == movie_theater_ship.theater_id and temp_hall_type == movie_theater_ship.hall_type and temp_hall_str == movie_theater_ship.hall_str
      k = {}

      k["ez_check_id"] = movie_theater_ship.theater.theaterez_id

      if movie_theater_ship.hall_type == [] and movie_theater_ship.hall_str == []
        time_sessions = movie_theater_ships.where(:theater_id => movie_theater_ship.theater_id,:hall_type => 'NULL',:hall_str=> 'NULL' )

      elsif movie_theater_ship.hall_type != [] and movie_theater_ship.hall_str == []
        time_sessions = movie_theater_ships.where(:theater_id => movie_theater_ship.theater_id,:hall_type => movie_theater_ship.hall_type,:hall_str=> 'NULL' )
      elsif movie_theater_ship.hall_type == [] and movie_theater_ship.hall_str != []
        time_sessions = movie_theater_ships.where(:theater_id => movie_theater_ship.theater_id,:hall_type => 'NULL',:hall_str=> movie_theater_ship.hall_str )
      else
        time_sessions = movie_theater_ships.where(:theater_id => movie_theater_ship.theater_id,:hall_type => movie_theater_ship.hall_type,:hall_str=> movie_theater_ship.hall_str )
      end  

      time_sessions_ary = [] 
      time_sessions.each do |time_session|
        t = {}
        t["time"] = time_session.timetable
        t["session_id"] = time_session.session_id
        time_sessions_ary << t
      end

      k["timeTable"] = time_sessions_ary
      k["hall_type"] = movie_theater_ship.hall_type
      k["hall_str"] = movie_theater_ship.hall_str
      k["theater"] = movie_theater_ship.theater.name
      k["theater_id"] = movie_theater_ship.theater_id
      k["ez_movie_id"] = movie_theater_ship.movieez_id
      kresponse << k
      temp = movie_theater_ship.theater_id 
      temp_hall_type = movie_theater_ship.hall_type
      temp_hall_str = movie_theater_ship.hall_str         
    end


    render :json => kresponse.to_json
  end
  
  def timetable
    movie_id = params[:id]
    theater_id = params[:theater_id]
    
    kresponse = []
    movie_theater_ships = EzMovieTheaterShip.includes(:theater).where(:movie_id => movie_id,:theater_id => theater_id)
    
    temp = 0
    temp_hall_type = 0
    temp_hall_str = 0

    movie_theater_ships.each do |movie_theater_ship|
      next if temp == movie_theater_ship.session_showdate and temp_hall_type == movie_theater_ship.hall_type and temp_hall_str == movie_theater_ship.hall_str
      k = {}

      k["ez_check_id"] = movie_theater_ship.theater.theaterez_id

      if movie_theater_ship.hall_type == [] and movie_theater_ship.hall_str == []
        time_sessions = movie_theater_ships.where(:theater_id => movie_theater_ship.theater_id,:hall_type => 'NULL',:hall_str=> 'NULL' )

      elsif movie_theater_ship.hall_type != [] and movie_theater_ship.hall_str == []
        time_sessions = movie_theater_ships.where(:theater_id => movie_theater_ship.theater_id,:hall_type => movie_theater_ship.hall_type,:hall_str=> 'NULL' )
      elsif movie_theater_ship.hall_type == [] and movie_theater_ship.hall_str != []
        time_sessions = movie_theater_ships.where(:theater_id => movie_theater_ship.theater_id,:hall_type => 'NULL',:hall_str=> movie_theater_ship.hall_str )
      else
        time_sessions = movie_theater_ships.where(:theater_id => movie_theater_ship.theater_id,:hall_type => movie_theater_ship.hall_type,:hall_str=> movie_theater_ship.hall_str )
      end  

      time_sessions_ary = [] 
      time_sessions.each do |time_session|
        t = {}
        t["time"] = time_session.timetable
        t["session_id"] = time_session.session_id
        time_sessions_ary << t
      end

      k["timeTable"] = time_sessions_ary
      k["hall_type"] = movie_theater_ship.hall_type
      k["hall_str"] = movie_theater_ship.hall_str
      k["theater"] = movie_theater_ship.theater.name
      k["date"] = movie_theater_ship.session_showdate
      k["ez_movie_id"] = movie_theater_ship.movieez_id
      kresponse << k
      temp = movie_theater_ship.session_showdate 
      temp_hall_type = movie_theater_ship.hall_type
      temp_hall_str = movie_theater_ship.hall_str  

    end  
    render :json => kresponse.to_json
  end
end

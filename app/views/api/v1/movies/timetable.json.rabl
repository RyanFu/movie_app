collection @ships
attributes :id, :timetable

node(:theater){ |ship| ship.theater.name }
node(:theater_id){|ship| ship.theater.id}
node(:area) { |ship| ship.area.name if ship.area} 
node(:buy_link){ |ship| ship.theater.buy_link }
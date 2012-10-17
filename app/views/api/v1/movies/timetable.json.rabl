collection @ships
attributes :id, :timetable

node(:theater){ |ship| ship.theater.name }
node(:area) { |ship| ship.area.name if ship.area} 
node(:buy_link){ |ship| ship.theater.buy_link }
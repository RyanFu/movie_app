collection @ships
attributes :id, :timetable,:hall_type,:hall_str

node(:theater){ |ship| ship.theater.name }
node(:theater_id){|ship| ship.theater.id}
node(:area) { |ship| ship.area.name if ship.area}
node(:area_id) { |ship| ship.area.id if ship.area} 
node(:buy_link){ |ship| ship.theater.buy_link }
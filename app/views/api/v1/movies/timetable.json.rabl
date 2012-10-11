collection @ships
attributes :id, :timetable

node(:theater){ |ship| ship.theater.name }
node(:buy_link){ |ship| ship.theater.buy_link }
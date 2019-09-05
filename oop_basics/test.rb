load "station.rb"
load "train.rb"
load "route.rb"

puts "Create train"
t1 = Train.new("train1", 'пассажирский', 6)
puts t1.inspect
puts "\n"

puts "Accelerate"
t1.accelerate(10)
puts t1.inspect
puts "\n"

puts "Try to detach car"
t1.detach_car
puts t1.inspect
puts "\n"

puts "Stop"
t1.decelerate(10)
puts t1.inspect
puts "\n"

puts "Try to detach car again"
t1.detach_car
puts t1.inspect
puts "\n"

puts "Attach car"
t1.attach_car
puts t1.inspect
puts "\n"

puts "Create more trains"
t2 = Train.new("train2", "пассажирский", 7)
t3 = Train.new('train3', "грузовой", 12)
puts t2.inspect, t3.inspect
puts "\n"

puts "Create Station"
st1 = Station.new("station1")
puts st1.inspect
puts "\n"

puts "Accept several trains"
st1.accept_train(t1)
st1.accept_train(t2)
st1.accept_train(t3)
puts st1.inspect
puts "\n"

puts "Return passenger trains"
st1.trains_by_type('пассажирский').each {|train| puts train.inspect}
puts "\n"

puts "Return passenger trains"
st1.trains_by_type('пассажирский').each {|train| puts train.inspect}
puts "\n"

puts "Return freight trains"
st1.trains_by_type('грузовой').each {|train| puts train.inspect}
puts "\n"

puts "Depart train"
st1.depart_train(t1)
puts st1.inspect
puts "\n"

puts "Create more stations"
st2 = Station.new("station2")
st3 = Station.new("station3")
st4 = Station.new("station4")
st5 = Station.new("station5")
puts "\n"

puts "Create route"
r1 = Route.new(st1, st5)
puts r1.show_stations
puts "\n"

puts "Add interim stations to route"
r1.add_station(st2)
r1.add_station(st3)
r1.add_station(st4)
puts r1.show_stations
puts "\n"

puts "Remove interim station"
r1.remove_station(st4)
r1.remove_station(st5)
puts r1.show_stations
puts "\n"

puts "Add station again"
r1.add_station(st4)
puts r1.show_stations
puts "\n"

puts "Train accepts route"
t1.accept_route(r1)
puts "Previous station: #{t1.prev_station}"
puts "Current station: #{t1.current_station.name}"
puts "Next station: #{t1.next_station.name}"
puts "\n"

puts "Try to move backwards"
t1.move_backwards
puts "Previous station: #{t1.prev_station}"
puts "Current station: #{t1.current_station.name}"
puts "Next station: #{t1.next_station.name}"

puts "\n"

puts "Move forward 4 times"
for i in 0..3
  t1.move_forward
  puts "Previous station: #{t1.prev_station.name}"
  puts "Current station: #{t1.current_station.name}"
  if t1.next_station != nil
    puts "Next station: #{t1.next_station.name}"
  else
    puts "Next station: #{t1.next_station}"
  end
  puts "\n"
end

puts "Try to move forward again"
t1.move_forward
puts "Previous station: #{t1.prev_station.name}"
puts "Current station: #{t1.current_station.name}"
puts "Next station: #{t1.next_station}"

puts "\n"

class Station
  attr_reader :trains, :name

  def initialize(name)
    @name = name
    @trains = []
  end

  def accept_train(train)
    @trains << train
  end

  def trains_by_type(type)
    @trains.select {|train| train.type == type}
  end

  def depart_train(train)
    @trains.delete(train)
  end

end

class Route
  attr_reader :start_station, :end_station, :interim_stations

  def initialize(start_station, end_station)
    @start_station = start_station
    @end_station = end_station
    @interim_stations = []
  end

  def add_station(station)
    @interim_stations << station
  end

  def remove_station(station)
    @interim_stations.delete(station)
  end

  def show_stations
    puts @start_station.name
    @interim_stations.each {|station| puts station.name}
    puts @end_station.name
  end
end

class Train
  attr_reader :cars_number, :speed, :current_station, :next_station, :prev_station, :type

  def initialize(number, type, cars_number)
    @number = number
    @type = type
    @cars_number = cars_number
    @speed = 0
    @current_station = nil
    @prev_station = nil
    @next_station = nil
  end

  def accelerate(speed_increment)
    @speed += speed_increment
  end

  def stop
    @speed = 0
  end
  
  def attach_car
    unless self.speed > 0
      @cars_number += 1
    end
  end

  def detach_car
    unless self.speed > 0 || self.cars_number == 0
      @cars_number -= 1
    end
  end

  def get_new_position(direction)
    stations = [@route.start_station]+@route.interim_stations+[@route.end_station]
    current_index = stations.index(self.current_station)
    new_index = current_index+direction
    if new_index < 0 || new_index >= stations.size
      return self.prev_station, self.current_station, self.next_station
    end
    prev_station = stations[current_index]
    current_station = stations[new_index]
    if direction > 0
      next_station= stations[new_index+1] 
    elsif new_index-1 > 0 
      next_station = stations[new_index-1]
    else
      next_station = nil
    end
    return prev_station, current_station, next_station
  end

  def accept_route(route)
    @route = route
    @current_station = route.start_station
    @prev_station = nil
    @next_station = route.interim_stations[0]
  end

  def move_forward
    unless @current_station == nil
      @prev_station, @current_station, @next_station = get_new_position(1)
    end
  end

  def move_backwards
    unless @current_station == nil
      @prev_station, @current_station, @next_station = get_new_position(-1)
    end
  end
end
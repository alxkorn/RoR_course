class Train
  attr_reader :cars_number, :speed, :type

  def initialize(number, type, cars_number)
    @number = number
    @type = type
    @cars_number = cars_number
    @speed = 0
  end

  def accelerate(speed_change)
    if speed_change > 0
      @speed += speed_change
    end
  end

  def decelerate(speed_change)
    if speed_change > 0
      if @speed - speed_change > 0
        @speed -= speed_change
      else
        @speed = 0
      end
    end
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

  def get_station(direction)
    if @current_station_index != nil and @current_station_index+direction >= 0
      @route.stations[@current_station_index+direction]
    end
  end

  def current_station
    get_station(0)
  end

  def next_station
    get_station(1)
  end

  def prev_station
    get_station(-1)
  end

  def accept_route(route)
    @route = route
    @current_station_index = 0
    self.current_station.accept_train(self)
  end

  def move_forward
    if @current_station_index != nil and @current_station_index+1 < @route.stations.size
      move(1)
    end
  end

  def move_backwards
    if @current_station_index != nil and @current_station_index-1 >= 0
      move(-1)
    end
  end

  def move(direction)
    self.current_station.depart_train(self)
    @current_station_index += direction
    self.current_station.accept_train(self)
  end
end
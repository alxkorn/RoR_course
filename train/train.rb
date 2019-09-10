# frozen_string_literal: true

class Train
  include Producer
  attr_reader :speed, :number, :cars, :route
  @@trains = []

  class << self
    def find(number)
      @@trains.find { |train| train.number == number }
    end
  end

  def initialize(number)
    @number = number
    @speed = 0
    @cars = []
    @@trains << self
  end

  def name
    number
  end

  def accelerate(speed_change)
    @speed += speed_change if speed_change.positive?
  end

  def decelerate(speed_change)
    return unless speed_change.positive?

    if (speed - speed_change).positive?
      self.speed -= speed_change
    else
      self.speed = 0
    end
  end

  def cars_number
    @cars.size
  end

  def show_cars
    @cars.each do |car|
      puts 'Номер вагона ', car.name
    end
  end

  def attach_car(car)
    @cars << car
    car.accept_train(self)
  end

  def detach_car(car)
    @cars.delete(car) unless speed.positive? || cars_number.zero?
    car.detach_train
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
    current_station.accept_train(self)
  end

  def show_route
    route.name
  end

  def move_forward
    return if @current_station_index.nil?

    shift = @current_station_index + 1
    return unless !@current_station_index.nil? && (shift < @route.stations.size)

    move(1)
  end

  def move_backwards
    return if @current_station_index.nil?

    shift = @current_station_index - 1
    return unless !@current_station_index.nil? && (shift >= 0)

    move(-1)
  end

  protected

  # этот метод помещен в protected, тк не хотим, чтобы имелся непосредственный доступ к скорости извне.
  # Однако внутри самого класса и внутри классов-потомков скорость изменятеся
  attr_writer :speed

  # эти методы помещены в protected, поскольку призваны лишь бороться с дублированием кода, они не должны вызыватьбся извне.
  def move(direction)
    current_station.depart_train(self)
    @current_station_index += direction
    current_station.accept_train(self)
  end

  def get_station(direction)
    shift = @current_station_index + direction
    return unless !@current_station_index.nil? && (shift >= 0)

    @route.stations[shift]
  end
end

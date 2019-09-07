# frozen_string_literal: true

class Manager
  def choose_option(options, args = nil)
    puts 'Выберите действие'
    options.each do |key, _value|
      puts [key[0], key[1]].join(' ')
    end
    action = gets.chomp
    options[action].call(*args)
  end

  def choose_object(entity, custom_text = nil)
    puts "Выберите #{custom_text}"
    entity.each_with_index do |object, index|
      puts [index.to_s, '-', object.name].join(' ')
    end

    object_index = gets.chomp.to_i
    entity[object_index]
  end
end

class StationManager < Manager
  attr_reader :stations
  def initialize(railroad)
    @stations = []
    @railroad = railroad
  end

  def station_operations
    options = { ['1', 'Создать станцию'] => method(:add_station),
                ['2', 'Просмотреть список станций'] => method(:show_stations_list),
                ['3', 'Просмотреть список поездов на станции'] => method(:show_trains_on_station),
                ['4', 'В меню'] => method(:railroad.main_menu) }

    choose_option(options)
  end

  def add_station
    puts 'Введите название станции: '
    name = gets
    stations << Station.new(name)
  end

  def show_stations_list
    stations.each { |station| puts station.name }
  end

  def show_trains_on_station
    station = choose_object(stations, 'станцию')
    return if station.trains.empty?

    station.trains.each do |train|
      puts 'Номер поезда: ', train.number, 'Тип поезда: ', train.type, "\n"
    end
  end

  protected

  attr_reader :railroad
end

class RouteManager < Manager
  attr_reader :routes
  def initialize(railroad)
    @routes = []
    @railroad = railroad
  end

  def route_operations
    options = { ['1', 'Создать маршрут'] => method(:add_route),
                ['2', 'Добавить/удалить станцию'] => method(:manage_route_stations),
                ['3', 'Назначить маршрут поезду'] => method(:assign_route_to_train),
                ['4', 'В меню'] => method(:railroad.main_menu) }

    choose_option(options)
  end

  def add_route
    start_station = choose_object(railroad.station_manager.stations, 'начальную станцию')
    end_station = choose_object(railroad.station_manager.stations, 'конечную станцию')

    return if start_station.nil? || end_station.nil?

    routes << Route.new(start_station, end_station)
  end

  def manage_route_stations
    route = choose_object(routes, 'маршрут')
    puts 'Выберите действие: '
    puts '1 - добавить станцию'
    puts '2 - удалить станцию'
    action = gets.chomp
    case action
    when '1'
      station = choose_object(railroad.station_manager.stations, 'станцию')
      route.add_station(station)
    when '2'
      station = choose_object(route.stations, 'станцию')
      route.remove_station(station)
    end
  end

  def assign_route_to_train
    route = choose_object(routes, 'маршрут')
    train = choose_object(railroad.train_manager.trains, 'поезд')
    train.accept_route(route)
  end

  protected

  attr_reader :railroad
end

class TrainManager < Manager
  attr_reader :trains
  attr_reader :cars
  def initialize(railroad)
    @trains = []
    @cars = []
    @railroad = railroad
    @train_types = { '1' => PassengerTrain, '2' => CargoTrain }
  end

  def train_operations
    options = { ['1', 'Создать поезд'] => method(:add_train),
                ['2', 'Создать вагон'] => method(:add_car),
                ['3', 'Двигать поезд'] => method(:move_train),
                ['4', 'Добавить/отцепить вагон'] => method(:manage_car),
                ['5', 'Просмотреть список вагонов поезда'] => method(:show_train_cars),
                ['6', 'Просмотреть список всех вагонов'] => method(:show_cars),
                ['7', 'В меню'] => method(:railroad.main_menu) }
    choose_option(options)
  end

  def add_train
    puts 'Выберите тип поезда: '
    puts '1 - пассажирский'
    puts '2 - грузовой'
    type = train_types[gets.chomp]

    return if type.nil?

    puts 'Введите номер поезда: '
    number = gets.chomp
    trains << type.new(number)
  end

  def move_train
    train = choose_object(trains, 'поезд')
    options = { ['1', 'Вперед '] => method(:move_forward),
                ['2', 'Назад '] => method(:move_backwards) }
    choose_option(options, [train])
  end

  def manage_car
    train = choose_object(trains, 'поезд')
    options = { ['1', 'Добавить вагон'] => attach_car(train),
                ['2', 'Отцепить вагон'] => detach_car(train) }
    choose_option(options)
  end

  def show_train_cars
    train = choose_object(trains)
    train.show_cars
  end

  def show_cars
    cars.each do |car|
      puts 'Номер вагона: ', car.name, 'Тип вагона: ', car.type
      puts 'Прицеплен к поезду: ', car.train.name unless car.train.nil?
    end
  end

  protected

  attr_reader :railroad, :train_types

  def move_forward(train)
    train.move_forward
  end

  def move_backwards(train)
    train.move_backwards
  end

  def attach_car(train)
    car = choose_object(cars)
    train.attach_car(car)
  end

  def detach_car(train)
    car = choose_object(train.cars)
    train.detach_car(car)
  end
end

class RailRoad < Manager
  WORKING_STATE = 'working'
  EXIT_STATE = 'exit'
  attr_reader :state
  def initialize
    @state = WORKING_STATE
  end

  def main_menu
    options = { ['1', 'Операции со станциями'] => station_operations,
                ['2', 'Операции с маршрутами'] => route_operations,
                ['3', 'Операции с поездами'] => train_operations,
                ['4', 'Выход '] => set_exit_state }
    choose_option(options)
    # puts '1 - Операции со станциями'
    # Создать станцию, просмотреть список станций, список поездов на станции
    # puts '2 - Операции с маршрутами'
    # Создать маршрут, добавить удалить станцию, назначить маршрут поезду
    # puts '3 - Операции с поездами'
    # Создать поезд, двигать поезд, добавить/отцепить вагон, создать вагон, список вагонов, информация о вагоне, информация о поезде
    # puts '4 - Выход'
  end

  protected

  attr_reader :trains
  attr_reader :train_types, :car_types
  attr_reader :routes

  def set_exit_state
    @state = EXIT_STATE
  end
end

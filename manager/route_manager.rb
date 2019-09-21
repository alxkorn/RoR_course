# frozen_string_literal: true

class RouteManager < Manager
  attr_reader :routes
  def initialize(railroad)
    @routes = []
    @railroad = railroad
  end

  def route_operations
    options = { '1' => [method(:add_route), 'Создать маршрут'],
                '2' => [method(:manage_route_stations), 'Добавить/удалить станцию'],
                '3' => [method(:assign_route_to_train), 'Назначить маршрут поезду'],
                '4' => [railroad.method(:main_menu), 'В меню'] }

    choose_option(options)
  end

  def add_route
    attempt = 0
    begin
      start_station = choose_object(railroad.station_manager.stations, 'начальную станцию')
      end_station = choose_object(railroad.station_manager.stations, 'конечную станцию')
      routes << Route.new(start_station, end_station)
    rescue InvalidFormatError => e
      attempt += 1
      puts e.message
      retry if attempt < 3
    end
  end

  def manage_route_stations
    route = choose_object(routes, 'маршрут')
    return if route.nil?

    puts 'Выберите действие: '
    puts '1 - добавить станцию'
    puts '2 - удалить станцию'
    action = gets.chomp
    case action
    when '1'
      station = choose_object(railroad.station_manager.stations, 'станцию')
      return if station.nil?

      route.add_station(station)
    when '2'
      station = choose_object(route.stations, 'станцию')
      return if station.nil?

      route.remove_station(station)
    end
  end

  def assign_route_to_train
    route = choose_object(routes, 'маршрут')
    train = choose_object(railroad.train_manager.trains, 'поезд')
    return if route.nil? || train.nil?

    train.accept_route(route)
  end

  protected

  attr_reader :railroad
end

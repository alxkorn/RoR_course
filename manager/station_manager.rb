# frozen_string_literal: true

class StationManager < Manager
  attr_reader :stations
  def initialize(railroad)
    @stations = []
    @railroad = railroad
  end

  def station_operations
    options = { '1' => [method(:add_station), 'Создать станцию'],
                '2' => [method(:show_stations_list), 'Просмотреть список станций'],
                '3' => [method(:show_trains_on_station), 'Просмотреть список поездов на станции'],
                '4' => [railroad.method(:main_menu), 'В меню'] }

    choose_option(options)
  end

  def add_station
    attempt = 0
    begin
      puts 'Введите название станции: '
      name = gets.chomp
      stations << Station.new(name)
    rescue InvalidFormatError => e
      attempt += 1
      puts e.message
      retry if attempt < 3
    end
  end

  def show_stations_list
    stations.each { |station| puts station.name }
  end

  def show_trains_on_station
    station = choose_object(stations, 'станцию')
    return if station.trains.nil?

    station.parse_trains do |train|
      puts 'Номер поезда: ', train.number, 'Тип поезда: ', train.type, "\n"
      puts "Количество вагонов #{train.cars_number}"
    end
  end

  protected

  attr_reader :railroad
end

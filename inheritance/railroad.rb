# frozen_string_literal: true

class RailRoad
  def initialize
    @stations = []
    @routes = []
    @trains = []
    @cars = []
    @train_types = { '1' => PassengerTrain, '2' => CargoTrain }
  end

  def add_station
    puts 'Введите название станции: '
    name = gets
    stations << Station.new(name)
  end

  def add_train
    puts 'Выберете тип поезда: '
    puts '1 - пассажирский'
    puts '2 - грузовой'
    type = train_types[gets.chomp]

    return if type.nil?

    puts 'Введите номер поезда: '
    number = gets.chomp
    trains << type.new(number)
  end

  protected

  attr_reader :stations, :trains
  attr_reader :train_types, :car_types
end

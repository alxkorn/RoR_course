# frozen_string_literal: true

class Route
  include InstanceCounter
  include Validation
  validate :start_station, :type, Station
  validate :end_station, :type, Station
  validate :stations, :route_start_end_valid

  attr_reader :stations
  def initialize(start_station, end_station)
    @start_station = start_station
    @end_station = end_station
    @stations = [@start_station, @end_station]
    validate!
    register_instance
  end

  def start_station
    @stations[0]
  end

  def end_station
    @stations[-1]
  end

  def add_station(station)
    @stations.insert(-2, station) unless stations.include? station
  end

  def remove_station(station)
    return unless station != @stations.last && station != stations.first

    @stations.delete(station)
  end

  def show_stations
    @stations.each { |station| puts station.name }
  end

  def name
    @stations[0].name + ' -> ' + @stations[-1].name
  end

  protected

  def route_start_end_valid(*args)
    raise InvalidFormatError, 'Start and End stations must be different' if stations[0].name == stations[-1].name
  end
end

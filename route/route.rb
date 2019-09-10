# frozen_string_literal: true

class Route
  include InstanceCounter
  self.count = 0
  attr_reader :stations
  def initialize(start_station, end_station)
    @stations = [start_station, end_station]
    register_instance
  end

  def start_station
    @stations[0]
  end

  def end_station
    @stations[-1]
  end

  def add_station(station)
    @stations.insert(-2, station)
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
end

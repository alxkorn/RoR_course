class Route
  attr_reader :stations
  def initialize(start_station, end_station)
    @stations = [start_station, end_station]
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
    if station != @stations.last && station != stations.first
      @stations.delete(station)
    end
  end

  def show_stations
    @stations.each {|station| puts station.name}
  end
end
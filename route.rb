require_relative 'instance_counter'

# doc
class Route
  include InstanceCounter

  attr_reader :stations

  def initialize(first_station, last_station)
    @stations = [first_station, last_station]
    validate!
    register_instance
  end

  def to_s
    "Route from #{first_station.name} to #{last_station.name}"
  end

  def valid?
    validate!
  rescue RuntimeError
    false
  end

  def first_station
    stations.first
  end

  def last_station
    stations.last
  end

  def add_station(station)
    raise 'Route already has this station' if stations.include?(station)
    stations.insert(-2, station)
  end

  def remove_station(station)
    raise 'You cannot remove first station' if station == first_station
    raise 'You cannot remove last station'  if station == last_station
    stations.delete(station)
  end

  def stations_list
    stations.each { |station| puts station.name }
  end

  protected

  def validate!
    if stations.class != Array || stations.size < 2
      raise 'Route has to have at least two stations'
    end
    if first_station == last_station
      raise 'First and last stations cannot be equal'
    end
    raise 'First station cannot be empty' if first_station.nil?
    raise 'Last station cannot be empty'  if last_station.nil?
    true
  end
end

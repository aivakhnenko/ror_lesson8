require_relative 'instance_counter'

# doc
class Station
  include InstanceCounter

  attr_reader :name, :trains

  @all_stations = []

  class << self
    attr_reader :all_stations

    def all
      all_stations
    end
  end

  def initialize(name)
    @name = name
    @trains = []
    validate!
    register_instance
    self.class.all_stations << self
  end

  def to_s
    "Station #{name}"
  end

  def valid?
    validate!
  rescue RuntimeError
    false
  end

  def arrive(train)
    trains << train
  end

  def depart(train)
    trains.delete(train)
  end

  def trains_by_type
    result_hash = Hash.new(0)
    trains.each { |train| result_hash[train.type] += 1 }
    result_hash
  end

  def each_train
    trains.each { |train| yield(train) }
  end

  protected

  def validate!
    raise 'Station name cannot be empty' if name.nil? || name.empty?
    true
  end
end

# frozen_string_literal: true

class Station
  include InstanceCounter
  include Validation
  NAME_TEMPLATE = /^[a-zа-я]{3,}+(?:[\s-][a-zа-я]+)*(?:[\s-]\d)*$/i.freeze
  validate :name, :type, String
  validate :name, :format, NAME_TEMPLATE

  attr_reader :trains, :name
  @@stations = []

  def initialize(name)
    @name = name
    validate!
    @trains = []
    @@stations << self
    register_instance
  end

  def parse_trains
    return unless block_given?

    trains.each { |train| yield(train) }
  end

  class << self
    def all
      @@stations
    end
  end

  def accept_train(train)
    @trains << train
  end

  def trains_by_type(type)
    @trains.select { |train| train.is_a? type }
  end

  def depart_train(train)
    @trains.delete(train)
  end
end

# frozen_string_literal: true

class Station
  attr_reader :trains, :name
  @@stations = []

  class << self
    def all
      @@stations
    end
  end

  def initialize(name)
    @name = name
    @trains = []
    @@stations << self
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

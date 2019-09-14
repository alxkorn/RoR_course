# frozen_string_literal: true

class Station
  include InstanceCounter

  attr_reader :trains, :name
  @@stations = []
  NAME_TEMPLATE = /^[a-zа-я]{3,}+(?:[\s-][a-zа-я]+)*(?:[\s-]\d)*$/i.freeze

  def initialize(name)
    @name = name
    validate!
    @trains = []
    @@stations << self
    register_instance
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

  def validate?
    validate!
    true
  rescue InvalidNameError
    false
  end

  protected

  def validate!
    raise InvalidNameError, 'Impermissible name format' if name !~ NAME_TEMPLATE
  end
end

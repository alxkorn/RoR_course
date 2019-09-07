# frozen_string_literal: true

class CargoTrain < Train
  attr_reader :type
  def initialize
    @type = 'грузовой'
  end

  def attach_car(car)
    return unless car.is_a? CargoCar

    super
  end
end

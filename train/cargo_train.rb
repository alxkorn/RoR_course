# frozen_string_literal: true

class CargoTrain < Train
  attr_reader :type
  def initialize(number)
    @type = 'грузовой'
    super
  end

  def attach_car(car)
    return unless car.is_a? CargoCar

    super
  end
end

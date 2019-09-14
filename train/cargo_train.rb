# frozen_string_literal: true

class CargoTrain < Train
  @type = 'грузовой'

  class << self
    attr_reader :type
  end

  def attach_car(car)
    return unless car.is_a? CargoCar

    super
  end
end

# frozen_string_literal: true

class CargoTrain < Train
  @@type = 'грузовой'

  def type
    @@type
  end

  def attach_car(car)
    return unless car.is_a? CargoCar

    super
  end
end

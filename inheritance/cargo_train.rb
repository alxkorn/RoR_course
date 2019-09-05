# frozen_string_literal: true

class CargoTrain < Train
  def attach_car(car)
    return unless car.is_a? CargoCar

    super
  end
end

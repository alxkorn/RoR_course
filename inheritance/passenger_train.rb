# frozen_string_literal: true

class PassengerTrain < Train
  def attach_car(car)
    return unless car.is_a? PassengerCar

    super
  end
end

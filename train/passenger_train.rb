# frozen_string_literal: true

class PassengerTrain < Train
  @@type = 'пассажирский'

  def type
    @@type
  end

  def attach_car(car)
    return unless car.is_a? PassengerCar

    super
  end
end

# frozen_string_literal: true

class PassengerTrain < Train
  attr_reader :type
  def initialize(number)
    @type = 'пассажирский'
    super
  end

  def attach_car(car)
    return unless car.is_a? PassengerCar

    super
  end
end

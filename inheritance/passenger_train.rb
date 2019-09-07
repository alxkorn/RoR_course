# frozen_string_literal: true

class PassengerTrain < Train
  attr_reader :type
  def initialize
    @type = 'пассажирский'
  end

  def attach_car(car)
    return unless car.is_a? PassengerCar

    super
  end
end

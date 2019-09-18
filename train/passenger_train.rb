# frozen_string_literal: true

class PassengerTrain < Train
  @type = 'пассажирский'
  class << self
    attr_reader :type
  end

  def attach_car(car)
    return unless car.is_a? PassengerCar

    super
  end
end

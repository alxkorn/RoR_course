# frozen_string_literal: true

class PassengerCar < Car
  @type = 'пассажирский'

  class << self
    def input_params
      [['Номер вагона', :to_s], ['Количество мест', :to_i]]
    end

    attr_reader :type
  end

  def take_space
    super(1)
  end
end

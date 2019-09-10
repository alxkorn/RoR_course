class PassengerCar < Car
  attr_reader :type
  def initialize(name)
    @type = 'пассажирский'
    super
  end
end

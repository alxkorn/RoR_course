class PassengerCar < Car
  attr_reader :type, :num_seats, :seats_taken
  def initialize(name, num_seats)
    @num_seats = num_seats
    @seats_taken = 0
    @type = 'пассажирский'
    super
  end

  def take_seat
    self.seats_taken += 1 if seats_taken + 1 <= num_seats
  end

  def free_seats
    num_seats - seats_taken
  end

  private

  attr_writer :seats_taken
end

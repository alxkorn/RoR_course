class PassengerCar < Car
  attr_reader :num_seats, :seats_taken
  @type = 'пассажирский'
  def initialize(name, num_seats)
    @num_seats = num_seats
    @seats_taken = 0
    super(name)
  end
  
  def take_seat
    self.seats_taken += 1 if seats_taken + 1 <= num_seats
  end

  def free_seats
    num_seats - seats_taken
  end

  class << self
    def input_params
      [['Номер вагона', :to_s], ['Количество мест', :to_i]]
    end

    attr_reader :type
  end

  private

  attr_writer :seats_taken
end

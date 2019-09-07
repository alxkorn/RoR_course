class Car
  attr_reader :name, :train
  def initialize(name)
    @name = name
  end

  def accept_train(train)
    return unless @train.nil?

    @train = train
  end

  def detach_train
    return if @train.nil?

    @train = nil
  end

  def train_number
    return if @train.nil?

    @train.number
  end
end
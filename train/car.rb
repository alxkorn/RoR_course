# frozen_string_literal: true

class Car
  include Producer
  attr_reader :name, :train, :space_taken, :total_space
  NUMBER_TEMPLATE = /\d{5}-?[a-zа-я]{2}/i.freeze

  def initialize(name, total_space)
    @name = name
    @total_space = total_space
    @space_taken = 0
    validate!
  end

  def take_space(space = 1)
    self.space_taken += space if space_taken + space <= total_space
  end

  def free_space
    total_space - space_taken
  end

  def accept_train(train)
    return unless @train.nil?

    @train = train
  end

  def type
    self.class.type
  end

  def detach_train
    return if @train.nil?

    @train = nil
  end

  def train_number
    return if @train.nil?

    @train.number
  end

  def validate?
    validate!
    true
  rescue InvalidNameError
    false
  end

  protected

  attr_writer :space_taken

  def validate!
    raise InvalidNameError, 'Impermissible number format' if name !~ NUMBER_TEMPLATE
  end
end

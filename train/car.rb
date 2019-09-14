# frozen_string_literal: true

class Car
  include Producer
  attr_reader :name, :train
  NUMBER_TEMPLATE = /\d{5}-?[a-zа-я]{2}/i.freeze

  def initialize(name)
    @name = name
    validate!
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

  def validate?
    validate!
    true
  rescue InvalidNameError
    false
  end

  protected

  def validate!
    raise InvalidNameError, 'Impermissible number format' if number !~ NUMBER_TEMPLATE
  end
end

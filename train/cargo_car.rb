# frozen_string_literal: true

class CargoCar < Car
  @type = 'грузовой'

  class << self
    def input_params
      [['Номер вагона', :to_s], ['Объем', :to_f]]
    end

    attr_reader :type
  end
end

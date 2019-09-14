class CargoCar < Car
  attr_reader  :total_volume, :volume_taken
  @@type = 'грузовой'
  def initialize(name, total_volume)
    @total_volume = total_volume
    @volume_taken = 0.0
    super(name)
  end

  def take_volume(vol)
    self.volume_taken += vol if volume_taken + vol <= total_volume
  end

  def free_volume
    total_volume - volume_taken
  end

  class << self
    def input_params
      [['Номер вагона', :to_s], ['Объем', :to_f]]
    end
    
    def type
      @@type
    end
  end

  private

  attr_writer :volume_taken
end

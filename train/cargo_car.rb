class CargoCar < Car
  attr_reader :type, :total_volume, :volume_taken
  def initialize(name, total_volume)
    @type = 'грузовой'
    @total_volume = total_volume
    @volume_taken = 0.0
    super
  end

  def take_volume(vol)
    self.volume_taken += vol if volume_taken + vol <= total_volume
  end

  def free_volume
    total_volume - volume_taken
  end

  private

  attr_writer :volume_taken
end

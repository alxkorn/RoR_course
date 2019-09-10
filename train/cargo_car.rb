class CargoCar < Car
  attr_reader :type
  def initialize(name)
    @type = 'грузовой'
    super
  end
end

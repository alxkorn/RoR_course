module InstanceCounter
  
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end
  
  module ClassMethods
    def instances
      count
    end
    attr_accessor :count
  end

  module InstanceMethods
    protected
    def register_instance
      self.class.count += 1
    end
  end
end
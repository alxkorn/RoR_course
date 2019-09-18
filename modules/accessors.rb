module Accessors
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    
    def my_attr_accessor(*names)
      names.each do |name|
        var_name = "@#{name}".to_sym
        define_method(name) { instance_variable_get(var_name) }
        attr_reader name
        define_method("#{name}=".to_sym) { |value| instance_variable_set(var_name, value) }
      end
    end
  end

  module InstanceMethods
  end
  
end

class Test
  include Accessors
  my_attr_accessor :a
end
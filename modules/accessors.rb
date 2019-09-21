# frozen_string_literal: true

module Accessors
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def attr_accessor_with_history(*names)
      names.each do |name|
        hist_reader_sym = "#{name}_history".to_sym
        hist_var_name = "@#{hist_reader_sym}".to_sym
        var_name = "@#{name}".to_sym
        attr_reader hist_reader_sym, name
        define_method("#{name}=".to_sym) do |value|
          instance_variable_set(hist_var_name, []) if instance_variable_get(hist_var_name).nil?
          instance_variable_get(hist_var_name) << value
          instance_variable_set(var_name, value)
        end
      end
    end

    def strong_attr_accessor(name, class_name)
      var_name = "@#{name}".to_sym
      attr_reader name
      define_method("#{name}=".to_sym) do |value|
        raise ArgumentError unless value.is_a? class_name

        instance_variable_set(var_name, value)
      end
    end
  end

  module InstanceMethods
  end
end

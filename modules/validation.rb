# frozen_string_literal: true

module Validation
  def self.included(base)
    base.extend Classmethods
    base.send :include, InstanceMethods
  end

  module Classmethods
    def validate(name, val_type, args = [])
      @validation_chart ||= []
      @validation_chart << [name, val_type, args]
    end

    def inherited(subclass)
      subclass.instance_variable_set(:@validation_chart, @validation_chart)
    end
  end

  module InstanceMethods
    def valid?
      validate!
      true
    rescue PresenceError, InvalidFormatError, InvalidTypeError
      false
    end

    protected

    def validate!
      validation_chart = self.class.instance_variable_get(:@validation_chart)
      instance = self
      validation_chart.each do |var_name, val_type, args|
        if Validation.respond_to? val_type
          Validation.send val_type, instance, var_name, args
        else
          send val_type, var_name, args
        end
      end
    end
  end

  def self.presence(*args)
    instance, var_name, = args
    var = instance.instance_variable_get("@#{var_name}".to_sym)
    message = "Variable #{var_name} is not present"
    raise PresenceError, message if var.nil? || ((var.is_a? String) && var.empty?)
  end

  def self.format(*args)
    instance, var_name, format_template, = args
    var = instance.instance_variable_get("@#{var_name}".to_sym)
    message = "Variable #{var_name} has invalid format, valid format: #{format_template}"
    raise InvalidFormatError, message unless var =~ format_template
  end

  def self.type(*args)
    instance, var_name, valid_type, = args
    var = instance.instance_variable_get("@#{var_name}".to_sym)
    message = "Variable #{var_name} should be of type #{valid_type}"
    raise InvalidTypeError, message unless var.is_a? valid_type
  end
end

# class Test
#   include Validation
#   validate :var, :presence
#   validate :var, :format, /[0-9]{3}/
#   validate :var, :type, String
#   def initialize(inp)
#     @var = inp
#   end

#   attr_accessor :var
# end

# module TestModule
#   def self.test_method
#     puts 'Hello'
#   end
# end
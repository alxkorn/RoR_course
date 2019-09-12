# frozen_string_literal: true

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
      # self.class.count = 0 if self.class.count.nil?
      self.class.count ||= 0
      self.class.count += 1
    end
  end
end

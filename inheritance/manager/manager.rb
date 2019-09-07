# frozen_string_literal: true

class Manager
  def choose_option(options, args = nil)
    puts 'Выберите действие'
    options.each do |key, value|
      puts [key[0], value[1]].join(' ')
    end
    action = gets.chomp
    options[action][0].call(*args)
  end

  def choose_object(entity, custom_text = nil)
    return if entity.empty?

    puts "Выберите #{custom_text}"
    entity.each_with_index do |object, index|
      puts [index.to_s, '-', object.name].join(' ')
    end

    object_index = gets.chomp.to_i
    entity[object_index]
  end
end

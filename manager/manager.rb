# frozen_string_literal: true

class Manager
  protected

  # Это вспомогательные методы для реализации меню, поскольку доступ к функционалу осуществляется через меню, прямой доступ к этим функциям не нужен
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
      if block_given?
        yield(object, index)
      else
        puts [index.to_s, '-', object.name].join(' ')
      end
    end
    object_index = gets.chomp.to_i
    entity[object_index]
  end

  def collect_input_params(params_desc)
    params = []
    params_desc.each do |message, func|
      puts "Введите #{message}:"
      params << gets.chomp.send(func)
    end
    params
  end
end

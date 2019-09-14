# frozen_string_literal: true

class TrainManager < Manager
  attr_reader :trains, :cars
  def initialize(railroad)
    @trains = []
    @cars = []
    @railroad = railroad
    @train_types = [PassengerTrain, CargoTrain]
    @car_types = [PassengerCar, CargoCar]
  end

  def train_operations
    options = { '1' => [method(:add_train), 'Создать поезд'],
                '2' => [method(:add_car), 'Создать вагон'],
                '3' => [method(:move_train), 'Двигать поезд'],
                '4' => [method(:manage_car), 'Добавить/отцепить вагон'],
                '5' => [method(:show_train_cars), 'Просмотреть список вагонов поезда'],
                '6' => [method(:show_cars), 'Просмотреть список всех вагонов'],
                '7' => [method(:train_info), 'Информация о поезде'],
                '8' => [railroad.method(:main_menu), 'В меню'] }
    choose_option(options)
  end

  def add_train
    # puts "Выберите тип поезда: \n1 - пассажирский \n2 - грузовой"
    type = choose_object(train_types, 'тип поезда') do |object, index| 
      puts [index.to_s, '-', object.type].join(' ')
    end
    return if type.nil?

    attempt = 0
    begin
      puts 'Введите номер поезда: '
      number = gets.chomp
      trains << type.new(number)
    rescue InvalidNameError => e
      attempt += 1
      puts e.message
      retry if attempt < 3
    end
  end

  def train_info
    train = choose_object(trains, 'поезд')
    return if train.nil?

    puts ['Номер поезда: ', train.name, 'Тип поезда: ', train.class.type].join(' ')
    train.show_cars unless train.cars.empty?
    unless train.route.nil?
      train.show_route
      puts ['Текущая станция: ', train.current_station.name].join
      puts ['Следующая станция: ', train.next_station.name].join unless train.next_station.nil?
      puts ['Предыдущая станция: ', train.prev_station.name].join unless train.prev_station.nil?
    end
  end

  def add_car
    # puts 'Выберите тип вагона: '
    # puts '1 - пассажирский'
    # puts '2 - грузовой'
    # type = car_types[gets.chomp]
    type = choose_object(car_types, 'тип вагона') do |object, index|
      puts [index.to_s, '-', object.type].join(' ')
    end
    return if type.nil?

    # puts 'Введите номер вагона: '
    # number = gets.chomp
    cars << type.new(*collect_input_params(type.input_params))
  end

  def move_train
    train = choose_object(trains, 'поезд')
    return if train.nil?

    options = { '1' => [method(:move_forward), 'Вперед '],
                '2' => [method(:move_backwards), 'Назад '] }
    choose_option(options, [train])
  end

  def manage_car
    train = choose_object(trains, 'поезд')
    return if train.nil?

    options = { '1' => [method(:attach_car), 'Добавить вагон'],
                '2' => [method(:detach_car), 'Отцепить вагон'] }
    choose_option(options, train)
  end

  def show_train_cars
    train = choose_object(trains)
    return if train.nil?

    train.show_cars
  end

  def show_cars
    cars.each do |car|
      puts ['Номер вагона: ', car.name, 'Тип вагона: ', car.type].join(' ')
      puts ['Прицеплен к поезду: ', car.train.name].join(' ') unless car.train.nil?
    end
  end

  protected

  attr_reader :railroad, :train_types, :car_types
  # методы призванные декомпозировать и упростить код интерфейса, доступ к ним - только через меню
  def move_forward(train)
    train.move_forward
  end

  def move_backwards(train)
    train.move_backwards
  end

  def attach_car(train)
    car = choose_object(cars)
    return if car.nil?

    train.attach_car(car)
  end

  def detach_car(train)
    car = choose_object(train.cars)
    return if car.nil?

    train.detach_car(car)
  end
end

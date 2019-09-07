# frozen_string_literal: true

class RailRoad < Manager
  WORKING_STATE = 'working'
  EXIT_STATE = 'exit'
  attr_reader :state, :train_manager, :route_manager, :station_manager
  def initialize
    @state = WORKING_STATE
    @station_manager = StationManager.new(self)
    @train_manager = TrainManager.new(self)
    @route_manager = RouteManager.new(self)
  end

  def main_menu
    options = { '1' => [station_manager.method(:station_operations), 'Операции со станциями'],
                '2' => [route_manager.method(:route_operations), 'Операции с маршрутами'],
                '3' => [train_manager.method(:train_operations), 'Операции с поездами'],
                '4' => [method(:set_exit_state), 'Выход '] }
    choose_option(options)
    # Создать станцию, просмотреть список станций, список поездов на станции
    # Создать маршрут, добавить удалить станцию, назначить маршрут поезду
    # Создать поезд, двигать поезд, добавить/отцепить вагон, создать вагон, список вагонов, информация о вагоне, информация о поезде
  end

  def exit_state
    EXIT_STATE
  end

  protected

  def set_exit_state
    @state = EXIT_STATE
  end
end

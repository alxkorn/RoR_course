# frozen_string_literal: true

require_relative 'exceptions/invalid_format_error'
require_relative 'exceptions/presence_error'
require_relative 'exceptions/invalid_type_error'

require_relative 'modules/producer'
require_relative 'modules/instance_counter'
require_relative 'modules/accessors'
require_relative 'modules/validation'

require_relative 'manager/manager'
require_relative 'manager/train_manager'
require_relative 'manager/station_manager'
require_relative 'manager/route_manager'
require_relative 'manager/railroad'

require_relative 'station/station'
require_relative 'route/route'

require_relative 'train/train'
require_relative 'train/car'
require_relative 'train/cargo_car'
require_relative 'train/passenger_car'
require_relative 'train/cargo_train'
require_relative 'train/passenger_train'

railroad = RailRoad.new
railroad.main_menu while railroad.state != railroad.exit_state

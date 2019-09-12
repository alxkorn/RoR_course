# frozen_string_literal: true
require_relative 'modules/producer'
require_relative 'modules/instance_counter'

require_relative 'manager/manager'
require_relative 'manager/train_manager'
require_relative 'manager/station_manager'
require_relative 'manager/route_manager'
require_relative 'manager/railroad'

require_relative 'route/route'

require_relative 'train/train'
require_relative 'train/car'
require_relative 'train/cargo_car'
require_relative 'train/passenger_car'
require_relative 'train/cargo_train'
require_relative 'train/passenger_train'

require_relative 'station/station'

railroad = RailRoad.new
railroad.main_menu while railroad.state != railroad.exit_state

# frozen_string_literal: true

require_relative 'train'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'station'
require_relative 'route'
require_relative 'wagon'
require_relative 'modules/menu'
require_relative 'modules/menu_actions/info_actions'
require_relative 'modules/menu_actions/route_actions'
require_relative 'modules/menu_actions/station_actions'
require_relative 'modules/menu_actions/train_actions'
require_relative 'modules/menu_actions/wagon_actions'

# Основной класс приложения для управления железнодорожной системой.
# Реализует консольный интерфейс пользователя и координирует взаимодействие между:
# - станциями (Station)
# - поездами (Train/PassengerTrain/CargoTrain)
# - маршрутами (Route)
# - вагонами (Wagon)
#
# Предоставляет полный цикл работы через меню:
# 1. Создание элементов системы
# 2. Управление маршрутами
# 3. Операции с поездами и вагонами
# 4. Просмотр текущего состояния системы
#
# Пример запуска:
#   main = Main.new
#   main.start
class Main
  include Menu
  include StationActions
  include TrainActions
  include RouteActions
  include WagonActions
  include InfoActions

  def initialize
    @stations = []
    @trains = []
    @routes = []
    @wagons = []
  end

  def start
    loop do
      show_menu
      choice = make_choice
      take_action(choice)
    end
  end

  private

  def make_choice
    puts 'Выберите действие: '
    gets.chomp.to_i
  end
end

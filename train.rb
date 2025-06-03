# frozen_string_literal: true

require_relative 'modules/instance_counter'
require_relative 'modules/manufacturing_companies'
require_relative 'modules/validators/validator'
require_relative 'modules/validators/train_validator'

# Класс Train представляет базовый поезд в железнодорожной системе.
# Реализует основную логику работы поездов и служит родительским классом
# для специализированных типов поездов (PassengerTrain и CargoTrain).
#
# Основные возможности:
# - Управление скоростью движения
# - Прицепка/отцепка вагонов
# - Назначение маршрута и перемещение между станциями
# - Поиск поездов по номеру
#
# Подключаемые модули:
# - InstanceCounter - подсчет созданных экземпляров
# - ManufacturingCompanies - информация о производителе
# - Validator - проверка корректности данных
#
# Пример использования:
#   train = Train.new('123-45', 'passenger')
#   train.assign_route(route)
#   train.go_forward
#
# Особенности:
# - Поддерживает два типа поездов: passenger и cargo
# - Требует строгого формата номера (XXX-XX или XXXXX)
# - Позволяет работать с вагонами только при остановке
# - Автоматически регистрируется в системе учета поездов
class Train
  include InstanceCounter
  include ManufacturingCompanies
  include Validation
  include TrainValidator

  attr_reader :number, :wagons, :type, :route, :current_station_index, :speed

  @trains = []

  class << self
    attr_reader :trains

    def find(number)
      trains.find { |train| train.number == number }
    end

    def all
      trains || []
    end

    def add_train(train)
      all << train
    end
  end

  def initialize(number, type)
    @number = number
    @type = type
    @wagons = []
    @speed = 0
    @route = nil
    @current_station_index = nil

    validate!

    self.class.add_train(self)
    register_instance
  end

  def stopped?
    speed.zero?
  end

  def stop
    self.speed = 0 unless stopped?
  end

  def speed_up(speed = 5)
    self.speed += speed
  end

  def speed_down(speed = 5)
    self.speed = [self.speed - speed, 0].max unless stopped?
  end

  def add_wagon(wagon)
    wagons << wagon if stopped?
  end

  def remove_wagon(wagon)
    wagons.delete(wagon) if stopped?
  end

  def assign_route(route)
    self.route = route
    self.current_station_index = 0
    current_station.add_train(self)
  end

  def current_station
    route.stations[current_station_index] if route?
  end

  def next_station
    route.stations[current_station_index + 1] unless last_station
  end

  def previous_station
    route.stations[current_station_index - 1] unless first_station
  end

  def go_forward
    move_to('forward')
  end

  def go_backward
    move_to('backward')
  end

  def each_wagon(&block)
    @wagons.each(&block)
  end

  private

  attr_writer :speed, :wagons, :route, :current_station_index

  def route?
    route
  end

  def last_station?
    route? && current_station_index == route.stations.size - 1
  end

  def first_station?
    route? && current_station_index.zero?
  end

  def move_to(type)
    return if (last_station? && type == 'forward') || (first_station? && type == 'backward')

    current_station.depart_train(self)
    direction = type == 'forward' ? 1 : -1
    self.current_station_index += direction
    current_station.add_train(self)
  end
end

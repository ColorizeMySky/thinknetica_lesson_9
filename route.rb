# frozen_string_literal: true

require_relative 'modules/instance_counter'
require_relative 'modules/validators/validator'
require_relative 'modules/validators/route_validator'

# Класс Route представляет маршрут следования поезда между станциями.
# Реализует логику управления последовательностью станций и включает:
# - Добавление промежуточных станций
# - Удаление станций из маршрута
# - Валидацию корректности маршрута
#
# Подключаемые модули:
# - InstanceCounter - для подсчета созданных маршрутов
# - Validator - для проверки корректности данных
#
# Пример использования:
#   first = Station.new('Москва')
#   last = Station.new('Санкт-Петербург')
#   route = Route.new(first, last)
#   route.add_station(Station.new('Тверь'))
#   route.stations # => [Москва, Тверь, Санкт-Петербург]
#
# Особенности:
# - При создании требует указания начальной и конечной станций
# - Автоматически проверяет валидность маршрута при инициализации
# - Позволяет добавлять станции на указанную позицию (по умолчанию предпоследнюю)
class Route
  include InstanceCounter
  include Validator
  include RouteValidator

  attr_reader :stations

  def initialize(first, last)
    @stations = [first, last]

    validate!

    register_instance
  end

  def add_station(station, position = -2)
    @stations.insert(position, station)
  end

  def remove_station(station)
    @stations.delete(station)
  end
end

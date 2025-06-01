# frozen_string_literal: true

require_relative 'modules/instance_counter'
require_relative 'modules/validators/validator'
require_relative 'modules/validators/station_validator'

# Класс Station представляет железнодорожную станцию в системе управления.
# Реализует логику работы с поездами на станции и включает:
# - Добавление/удаление поездов
# - Фильтрацию поездов по типу
# - Итерацию по всем поездам
# - Валидацию названия станции
#
# Подключаемые модули:
# - InstanceCounter - для подсчета созданных станций
# - Validator - для проверки корректности данных
#
# Пример использования:
#   station = Station.new('Москва-Пассажирская')
#   station.add_train(PassengerTrain.new('123-45'))
#   station.trains_by_type('passenger') # => 1
#
# Особенности:
# - Поддерживает класс-метод all для получения всех созданных станций
# - Автоматически проверяет валидность названия при создании
# - Ограничивает длину названия (2-50 символов)
# - Разрешает только буквы, цифры, пробелы и дефисы в названии
class Station
  include InstanceCounter
  include Validator
  include StationValidator

  attr_reader :title, :trains

  @stations = []

  class << self
    attr_reader :stations

    def all
      stations
    end

    def add_station(station)
      stations << station
    end
  end

  def initialize(title)
    @title = title
    @trains = []

    validate!

    self.class.add_station(self)
    register_instance
  end

  def add_train(train)
    @trains << train
  end

  def depart_train(train)
    @trains.delete(train)
  end

  def trains_by_type(type)
    @trains.count { |train| train.type == type }
  end

  def each_train(&block)
    @trains.each(&block)
  end
end

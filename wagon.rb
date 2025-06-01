# frozen_string_literal: true

require_relative 'modules/manufacturing_companies'
require_relative 'modules/validators/validator'
require_relative 'modules/validators/wagon_validator'

# Базовый класс Wagon представляет железнодорожный вагон в системе.
# Содержит общую логику для всех типов вагонов и служит родительским классом
# для специализированных вагонов (CargoWagon и PassengerWagon).
#
# Основные возможности:
# - Хранение информации о типе вагона (грузовой/пассажирский)
# - Учет занятого и свободного места
# - Базовые проверки при добавлении груза/пассажиров
#
# Подключаемые модули:
# - ManufacturingCompanies - информация о производителе вагона
# - Validator - проверка корректности данных
#
# Пример использования (через дочерние классы):
#   wagon = PassengerWagon.new(50)  # Вагон на 50 мест
#   wagon.take_seat                # Занимает 1 место
#
# Особенности:
# - Не предназначен для прямого создания экземпляров
# - Требует указания типа при инициализации (cargo/passenger)
# - Предоставляет защищенный интерфейс для работы с вместимостью
# - Автоматически проверяет валидность данных при создании
class Wagon
  include ManufacturingCompanies
  include Validator
  include WagonValidator

  attr_reader :type

  def initialize(type, total_place)
    @type = type
    @total_place = total_place
    @used_place = 0

    validate!
  end

  protected

  attr_reader :used_place, :total_place

  def take_place(place)
    raise 'Вагон полностью заполнен' if @used_place == @total_place
    raise "Недостаточно места. Доступно: #{free_place}" if place > free_place

    @used_place += place
  end

  def free_place
    @total_place - @used_place
  end
end

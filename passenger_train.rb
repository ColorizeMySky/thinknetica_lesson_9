# frozen_string_literal: true

# Класс PassengerTrain представляет пассажирский поезд в железнодорожной системе.
# Наследует базовую функциональность от класса Train и добавляет специфичные
# для пассажирских поездов особенности:
# - Автоматическое установление типа поезда как 'passenger' при инициализации
# - Проверку типа прицепляемых вагонов (только пассажирские)
#
# Пример использования:
#   train = PassengerTrain.new('123-45')
#   wagon = PassengerWagon.new(50)  # Вагон на 50 мест
#   train.add_wagon(wagon)          # Успешно добавит вагон
#
# Отличия от грузовых поездов:
# - Работает только с пассажирскими вагонами
# - Имеет соответствующий тип ('passenger')
class PassengerTrain < Train
  def initialize(number)
    super(number, 'passenger')
  end

  def add_wagon(wagon)
    return unless wagon.type == 'passenger'

    super
  end
end

# frozen_string_literal: true

# Класс CargoTrain представляет грузовой поезд в железнодорожной системе.
# Наследует базовую функциональность от класса Train и добавляет специфичные
# для грузовых поездов особенности:
# - Автоматическое установление типа поезда как 'cargo' при инициализации
# - Специальную проверку типа прицепляемых вагонов (только грузовые)
#
# Пример использования:
#   train = CargoTrain.new('123-45')
#   wagon = CargoWagon.new(1000)
#   train.add_wagon(wagon) # успешно добавит вагон
class CargoTrain < Train
  def initialize(number)
    super(number, 'cargo')
  end

  def add_wagon(wagon)
    return unless wagon.type == 'cargo'

    super
  end
end

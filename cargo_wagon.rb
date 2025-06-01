# frozen_string_literal: true

# Класс CargoWagon представляет грузовой вагон в железнодорожной системе.
# Наследует базовую функциональность от класса Wagon и специализируется для работы
# с грузовыми перевозками, предоставляя:
#
# * Интерфейс для работы с объемом (вместо абстрактного "места"):
#   - take_volume - занять определенный объем
#   - used_volume - занятый объем (алиас для used_place)
#   - total_volume - общий доступный объем (алиас для total_place)
#
# Пример использования:
#   wagon = CargoWagon.new(1000)  # Создает вагон с общим объемом 1000
#   wagon.take_volume(500)        # Занимает 500 объема
#   wagon.used_volume             # => 500
#   wagon.total_volume            # => 1000
class CargoWagon < Wagon
  alias used_volume used_place
  alias total_volume total_place
  public :used_volume, :total_volume

  def initialize(total_volume)
    super('cargo', total_volume)
  end

  def take_volume(volume)
    take_place(volume)
  end
end

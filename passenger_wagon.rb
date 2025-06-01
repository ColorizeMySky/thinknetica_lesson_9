# frozen_string_literal: true

# Класс PassengerWagon представляет пассажирский вагон железнодорожного состава.
# Наследует базовую функциональность от класса Wagon и специализируется для перевозки пассажиров,
# предоставляя удобный интерфейс для работы с пассажирскими местами.
#
# Основные характеристики:
# - Автоматически устанавливает тип 'passenger' при создании
# - Предоставляет методы для работы с пассажирскими местами:
#   * take_seat - занять одно пассажирское место
#   * busy_seats - получить количество занятых мест (алиас used_place)
#   * total_seats - получить общее количество мест (алиас total_place)
#
# Пример использования:
#   wagon = PassengerWagon.new(50)  # Создает вагон с 50 местами
#   wagon.take_seat                # Занимает одно место
#   wagon.busy_seats               # => 1
#   wagon.total_seats              # => 50
#
# Особенности:
# - Занимать можно только по одному месту за раз
# - Все места равнозначны (нет разделения на классы)
class PassengerWagon < Wagon
  alias busy_seats used_place
  alias total_seats total_place
  public :busy_seats, :total_seats

  def initialize(seats)
    super('passenger', seats)
  end

  def take_seat
    take_place(1)
  end
end

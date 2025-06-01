# frozen_string_literal: true

# Модуль RouteValidator предоставляет базовую валидацию для маршрутов.
# Выполняет проверки корректности начальной и конечной станций маршрута.
#
# Основные проверки:
# - Наличие начальной станции
# - Наличие конечной станции
# - Несовпадение начальной и конечной станций
#
# Использование:
#   class Route
#     include RouteValidator
#
#     def initialize(first_station, last_station)
#       @stations = [first_station, last_station]
#       validate!
#     end
#   end
#
# Особенности:
# - Все методы модуля являются private
# - Генерирует исключение с перечнем ошибок при невалидных данных
# - Ожидает, что включающий класс имеет массив @stations с минимум 2 элементами
# - Сообщения об ошибках содержат понятные указания на проблему
#
# Исключения:
#   Вызывает RuntimeError с объединенным списком ошибок, если валидация не пройдена
module RouteValidator
  private

  def validate!
    errors = []
    errors << 'Начальная станция не может отсутствовать' if @stations.first.nil?
    errors << 'Конечная станция не может отсутствовать' if @stations.last.nil?
    errors << 'Начальная и конечная станции не могут совпадать' if @stations.first == @stations.last

    raise errors.join("\n") unless errors.empty?
  end
end

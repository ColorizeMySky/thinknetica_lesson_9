# frozen_string_literal: true

# Модуль для валидации типа железнодорожного вагона.
#
# Предоставляет базовые проверки корректности типа вагона перед его использованием в системе.
# Включается в классы вагонов для обеспечения стандартной валидации.
#
# @example Подключение и использование
#   class Wagon
#     include WagonValidator
#
#     attr_reader :type
#
#     def initialize(type)
#       @type = type
#       validate! # вызов валидации при инициализации
#     end
#   end
#
# @example Генерируемые исключения
#   wagon = CargoWagon.new('') # => RuntimeError: Тип вагона не может отсутствовать
#   wagon = CargoWagon.new('tank') # => RuntimeError: Неизвестный тип вагона...
module WagonValidator
  private

  def validate!
    raise 'Тип вагона не может отсутствовать' if type.to_s.strip.empty?
    raise "Неизвестный тип вагона. Допустимые значения: 'cargo', 'passenger'" unless %w[cargo passenger].include?(type)
  end
end

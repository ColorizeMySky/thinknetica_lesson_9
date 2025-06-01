# frozen_string_literal: true

# Модуль для валидации данных объектов.
# Предоставляет базовую функциональность проверки валидности состояния объекта.
#
# Используется через включение (include) в классы, требующие валидации.
# Требует реализации метода #validate! в включаемом классе.
#
# Пример использования:
#   class MyClass
#     include Validator
#
#     def validate!
#       raise 'Ошибка валидации' if some_condition
#     end
#   end
#
#   obj = MyClass.new
#   obj.valid? # => true/false
module Validator
  def valid?
    validate!
    true
  rescue StandardError
    false
  end
end

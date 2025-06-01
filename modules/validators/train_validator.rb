# frozen_string_literal: true

require_relative './validator'

# Модуль TrainValidator предоставляет функциональность валидации атрибутов поезда.
# Включает проверки:
# - Наличие и формат номера поезда
# - Корректность типа поезда
#
# Используется в классе Train для проверки данных при создании экземпляра.
#
# Пример использования:
#   class Train
#     include TrainValidator
#     VALID_TYPES = %w[cargo passenger].freeze
#     NUMBER_FORMAT = /^[a-zа-я0-9]{3}-?[a-zа-я0-9]{2}$/i.freeze
#   end
#
#   train = Train.new('123-45', 'passenger') # вызовет validate!
#
# Особенности:
# - Все методы модуля являются private
# - Генерирует исключения с перечнем ошибок при невалидных данных
# - Предполагает наличие констант VALID_TYPES и NUMBER_FORMAT в включающем классе
# - Требует наличия атрибутов number и type у включающего класса
module TrainValidator
  include Validation

  NUMBER_FORMAT = /^[a-zа-я0-9]{3}-?[a-zа-я0-9]{2}$/i.freeze
  VALID_TYPES = %w[cargo passenger].freeze

  private

  def validate!
    super
    errors = []
    validate_number(errors)
    validate_type(errors)

    raise errors.join("\n") unless errors.empty?
  end

  def validate_number(errors)
    errors << 'Номер не может отсутствовать' if number.to_s.strip.empty?
    errors << 'Номер имеет недопустимый формат' if number !~ NUMBER_FORMAT
  end

  def validate_type(errors)
    errors << 'Тип поезда не может отсутствовать' if type.to_s.strip.empty?
    errors << "Неизвестный тип поезда. Допустимые значения: #{VALID_TYPES.join(', ')}" unless VALID_TYPES.include?(type)
  end
end

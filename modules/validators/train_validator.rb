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

  def self.included(base)
    base.extend Validation::ClassMethods
    base.include Validation::InstanceMethods

    base.class_eval do
      validate :number, :presence, "Номер не может быть пустым"
      validate :number, :format, NUMBER_FORMAT, "Номер имеет недопустимый формат"
    end
  end
end

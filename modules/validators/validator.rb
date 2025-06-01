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
module Validation
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    def validate(name, validation_type, *options)
      validations << { name: name, type: validation_type, options: options }
    end

    def validations
      @validations ||= []
    end
  end

  module InstanceMethods
    def validate!
      self.class.validations.each do |validation|
        value = instance_variable_get("@#{validation[:name]}".to_sym)
        send("validate_#{validation[:type]}", validation[:name], value, *validation[:options])
      end
    end

    def valid?
      validate!
      true
    rescue
      false
    end

    private

    def validate_presence(name, value)
      raise "#{name} can't be blank" if value.nil? || (value.is_a?(String) && value.empty?)
    end

    def validate_format(name, value, regex)
      raise "#{name} has invalid format" unless value.to_s.match(regex)
    end

    def validate_type(name, value, klass)
      raise "#{name} must be #{klass}" unless value.is_a?(klass)
    end
  end
end

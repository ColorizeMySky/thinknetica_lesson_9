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
      superclass.respond_to?(:validations) ? superclass.validations.dup + (@validations || []) : (@validations ||= [])
    end
  end

  module InstanceMethods
    def validate!
      puts(555, self.class.validations)
      self.class.validations.each do |validation|
        puts(222, "inside validate", validation)
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

    def validate_presence(name, value, message = nil)
      puts(444, "validate_presence")
      message ||= "#{name} не может быть пустым"
      raise message if value.nil? || (value.is_a?(String) && value.empty?)
    end

    def validate_format(name, value, regex, message = nil)
      puts(333, "validate_format")
      message ||= "#{name} содержит недопустимые символы"
      raise message unless value.to_s.match(regex)
    end

    def validate_type(name, value, klass)
      raise "#{name} must be #{klass}" unless value.is_a?(klass)
    end
  end
end

# frozen_string_literal: true

# Модуль для расширения стандартного функционала attr_accessor
# Добавляет два новых метода для определения атрибутов:
#
# 1. attr_accessor_with_history - создает атрибут с историей изменений
# 2. strong_attr_accessor - создает атрибут с проверкой типа
#
# Пример использования:
#   class Test
#     extend Accessors
#
#     attr_accessor_with_history :foo, :bar
#     strong_attr_accessor :baz, String
#   end
#
# Особенности:
# - Поддерживает множественное определение атрибутов для history-версии
# - Выбрасывает исключение при несоответствии типа в strong_attr_accessor
# - Сохраняет полную историю изменений для каждого атрибута
# - Не требует дополнительных зависимостей
module Accessors
  def attr_accessor_with_history(*names)
    names.each { |name| define_history_accessor(name) }
  end

  def strong_attr_accessor(name, klass)
    var_name = "@#{name}".to_sym

    define_method(name) { instance_variable_get(var_name) }

    define_method("#{name}=") do |value|
      raise "Invalid type. Expected #{klass}, got #{value.class}" unless value.is_a?(klass)

      instance_variable_set(var_name, value)
    end
  end

  private

  def define_history_accessor(name)
    var_name = "@#{name}".to_sym
    history_var = "@#{name}_history".to_sym

    define_getter(name, var_name)
    define_setter(name, var_name, history_var)
    define_history_getter(name, history_var)
  end

  def define_getter(name, var_name)
    define_method(name) { instance_variable_get(var_name) }
  end

  def define_setter(name, var_name, history_var)
    define_method("#{name}=") do |value|
      update_history(history_var, var_name)
      instance_variable_set(var_name, value)
    end
  end

  def define_history_getter(name, history_var)
    define_method("#{name}_history") { instance_variable_get(history_var) || [] }
  end

  def update_history(history_var, var_name)
    history = instance_variable_get(history_var) || []
    instance_variable_set(history_var, history << instance_variable_get(var_name))
  end
end

# frozen_string_literal: true

# Модуль для подсчета созданных экземпляров классов.
# Позволяет отслеживать количество созданных объектов любого класса,
# в который он включен.
#
# Пример использования:
#   class MyClass
#     include InstanceCounter
#   end
#
#   MyClass.new
#   MyClass.instances_count # => 1
module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  # Подмодуль с методами класса для работы со счетчиком экземпляров
  module ClassMethods
    attr_reader :instances_count

    def instances
      @instances ||= 0
    end

    def increment_instances_count
      @instances_count = instances + 1
    end
  end

  # Подмодуль с методами экземпляра для работы со счетчиком
  module InstanceMethods
    private

    def register_instance
      self.class.increment_instances_count
    end
  end
end

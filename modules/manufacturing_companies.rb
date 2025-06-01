# frozen_string_literal: true

# Модуль для добавления функциональности работы с названием компании-производителя.
# Предоставляет:
#   - публичный геттер #company_name
#   - защищенный сеттер #company_name=
#
# Использование:
#   class Train
#     include ManufacturingCompanies
#
#     def initialize(company)
#       self.company_name = company  # Вызов защищенного метода
#     end
#   end
#
#   train = Train.new('Bombardier')
#   train.company_name  # => "Bombardier"
module ManufacturingCompanies
  attr_reader :company_name

  protected

  attr_writer :company_name
end

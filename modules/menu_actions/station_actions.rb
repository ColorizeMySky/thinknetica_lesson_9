# frozen_string_literal: true

# Модуль для работы со станциями в железнодорожной системе.
# Содержит методы для создания и управления станциями.
#
# Предоставляет:
# - Создание новых станций
# - Обработку ошибок при создании
module StationActions
  private

  def create_station
    puts 'Введите название станции: '
    name = gets.chomp
    @stations << Station.new(name)
  rescue StandardError => e
    puts "Ошибка: #{e.message}"
    retry
  end
end

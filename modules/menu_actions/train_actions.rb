# frozen_string_literal: true

# Модуль для работы с поездами в железнодорожной системе.
# Содержит методы для создания поездов и управления их движением.
#
# Предоставляет:
# - Создание пассажирских и грузовых поездов
# - Управление движением поездов по маршруту
# - Обработку ошибок при операциях с поездами
module TrainActions
  private

  def create_train
    puts 'Введите номер поезда: '
    number = gets.chomp
    puts 'Выберите тип (1 - пассажирский, 2 - грузовой): '
    type = gets.chomp.to_i

    case type
    when 1
      @trains << PassengerTrain.new(number)
      type = 'пассажирский'
    when 2
      @trains << CargoTrain.new(number)
      type = 'грузовой'
    else
      raise 'Неизвестный тип вагона. Допустимые значения: "cargo", "passenger"'
    end

    puts "Создан поезд № #{number} (#{type})"
  rescue StandardError => e
    puts "Ошибка: #{e.message}"
    retry
  end

  def move_train
    select_entity(@trains)
    puts 'Выберите направление (1 - вперед, 2 - назад): '
    direction = gets.chomp.to_i

    direction == 1 ? @selected_train.go_forward : @selected_train.go_backward
  end
end

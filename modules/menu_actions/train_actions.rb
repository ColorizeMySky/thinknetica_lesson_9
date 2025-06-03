# frozen_string_literal: true

require_relative '../../passenger_wagon'
require_relative '../../cargo_wagon'

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
    number, type = ask_train_details
    train = build_train(number, type)
    @trains << train

    puts "Создан поезд № #{number} (#{type == 1 ? 'пассажирский' : 'грузовой'})"
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

  def ask_train_details
    puts 'Введите номер поезда: '
    number = gets.chomp
    puts 'Выберите тип (1 - пассажирский, 2 - грузовой): '
    [number, gets.chomp.to_i]
  end

  def build_train(number, type)
    case type
    when 1 then PassengerTrain.new(number)
    when 2 then CargoTrain.new(number)
    else raise 'Неизвестный тип поезда'
    end
  end
end

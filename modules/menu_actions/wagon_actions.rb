# frozen_string_literal: true

# Модуль для работы с вагонами в железнодорожной системе.
# Содержит методы для создания вагонов и управления их содержимым.
#
# Предоставляет:
# - Создание пассажирских и грузовых вагонов
# - Добавление/удаление вагонов из поездов
# - Загрузку вагонов (посадку пассажиров или загрузку груза)
# - Обработку ошибок при операциях с вагонами
module WagonActions
  private

  def create_wagon
    puts 'Выберите тип вагона (1 - пассажирский, 2 - грузовой): '
    type = gets.chomp.to_i

    wagon = type == 1 ? create_passenger_wagon : create_cargo_wagon
    @wagons << wagon
  rescue StandardError => e
    puts "Ошибка: #{e.message}"
    retry
  end

  def add_wagon_to_train
    select_entity(@trains)
    wagon = Wagon.new(@selected_train.type)
    @selected_train.add_wagon(wagon)
    @wagons << wagon
  end

  def remove_wagon_from_train
    select_entity(@trains)
    return if @selected_train.wagons.empty?

    wagon = @selected_train.wagons.last
    @selected_train.remove_wagon(wagon)
  end

  def occupy_space_in_wagon
    select_entity(@trains)
    puts 'Номер вагона: '
    wagon = @selected_train.wagons[gets.to_i - 1]

    wagon.type == :passenger ? occupy_seat(wagon) : occupy_volume(wagon)
  rescue StandardError => e
    puts "Ошибка: #{e.message}"
  end

  def create_passenger_wagon
    puts 'Введите количество мест: '
    seats = gets.chomp.to_i
    PassengerWagon.new(seats)
  end

  def create_cargo_wagon
    puts 'Введите объем вагона: '
    volume = gets.chomp.to_f
    CargoWagon.new(volume)
  end

  def occupy_seat(wagon)
    wagon.take_seat
    puts 'Занято одно место'
  end

  def occupy_volume(wagon)
    volume = gets.to_f
    wagon.take_volume(volume)
    puts "Занято #{volume} объёма"
  end
end

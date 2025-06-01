# frozen_string_literal: true

# Модуль для отображения информации о железнодорожной системе.
# Содержит методы для вывода текущего состояния системы.
#
# Предоставляет:
# - Отображение информации о станциях и поездах
# - Просмотр состояния вагонов
# - Выбор сущностей из списка
module InfoActions
  private

  def show_info
    @stations.each do |station|
      puts "\nСтанция #{station.title}:"
      station.trains.empty? ? puts('- Поездов нет') : show_trains(station)
    end
  end

  def select_entity(collection)
    case collection
    when @stations then puts 'Выберите станцию: '
    when @trains then puts 'Выберите поезд: '
    when @routes then puts 'Выберите маршрут: '
    end
    entity_index = gets.chomp.to_i - 1
    @selected_entity = collection[entity_index]
  end

  def show_trains(station)
    station.each_train do |train|
      puts "- Поезд №#{train.number} (#{train.type}), вагонов: #{train.wagons.size}"
      train.each_wagon { |wagon| show_wagon_info(train.type, wagon) }
    end
  end

  def show_wagon_info(train_type, wagon)
    wagon_info = if train_type == :passenger
                   "свободно мест: #{wagon.free_seats}, занято: #{wagon.occupied_seats}"
                 else
                   "свободный объем: #{wagon.free_volume}, занято: #{wagon.occupied_volume}"
                 end
    puts "-- Вагон #{wagon.object_id}: #{wagon_info}"
  end
end

# frozen_string_literal: true

# Модуль для работы с маршрутами в железнодорожной системе.
# Содержит методы для создания и изменения маршрутов.
#
# Предоставляет:
# - Создание новых маршрутов между станциями
# - Добавление и удаление станций из маршрута
# - Обработку ошибок при операциях с маршрутами
module RouteActions
  private

  def create_route
    puts 'Введите номер начальной станции: '
    first_index = gets.chomp.to_i - 1
    puts 'Введите номер конечной станции: '
    last_index = gets.chomp.to_i - 1

    route = Route.new(@stations[first_index], @stations[last_index])
    @routes << route
  rescue StandardError => e
    puts "Ошибка: #{e.message}"
    retry
  end

  def add_station_to_route
    @selected_route = select_entity(@routes)
    puts 'Введите номер станции для добавления: '
    station_index = gets.chomp.to_i - 1
    puts 'Введите позицию (по умолчанию предпоследняя): '
    position = gets.chomp.to_i

    @selected_route.add_station(@stations[station_index], position)
  end

  def remove_station_from_route
    select_entity(@routes)
    puts 'Введите номер станции для удаления: '
    station_index = gets.chomp.to_i - 1

    @selected_route.remove_station(@selected_route.stations[station_index])
  end

  def assign_route_to_train
    @selected_train = select_entity(@trains)
    @selected_route = select_entity(@routes)
    @selected_train.assign_route(@selected_route)
  end
end

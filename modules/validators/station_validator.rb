# frozen_string_literal: true

# Модуль StationValidator предоставляет валидацию названий железнодорожных станций.
# Выполняет комплексную проверку корректности названия станции по трем критериям:
#
# 1. Проверка наличия названия (не пустое)
# 2. Проверка длины названия (2..50 символов)
# 3. Проверка формата названия (только буквы, цифры, пробелы и дефисы)
#
# Константы:
#   TITLE_FORMAT - регулярное выражение для проверки формата (/^[a-zа-я0-9\s-]+$/i)
#   MIN_TITLE_LENGTH - минимальная допустимая длина названия (2)
#   MAX_TITLE_LENGTH - максимальная допустимая длина названия (50)
#
# Пример использования:
#   class Station
#     include StationValidator
#     attr_reader :title
#
#     def initialize(title)
#       @title = title
#       validate!
#     end
#   end
#
#   station = Station.new("Москва-Пассажирская") # пройдет валидацию
#   station = Station.new("") # вызовет исключение с сообщением об ошибке
#
# Особенности:
# - Все методы модуля являются private
# - Генерирует RuntimeError с перечнем всех найденных ошибок
# - Требует наличия метода #title у включающего класса
# - Сообщения об ошибках содержат конкретные требования
# - Поддерживает кириллические и латинские символы в названиях
#
# Методы:
#   validate!       - основной метод, запускающий все проверки
#   validate_presence - проверяет наличие названия
#   validate_length   - проверяет длину названия
#   validate_format   - проверяет допустимость символов
module StationValidator
  TITLE_FORMAT = /^[a-zа-я0-9\s-]+$/i.freeze
  MIN_TITLE_LENGTH = 2
  MAX_TITLE_LENGTH = 50

  private

  def validate!
    errors = []
    validate_presence(errors)
    validate_length(errors)
    validate_format(errors)

    raise errors.join("\n") unless errors.empty?
  end

  def validate_presence(errors)
    errors << 'Название не может отсутствовать' if title.to_s.strip.empty?
  end

  def validate_length(errors)
    if title.length < MIN_TITLE_LENGTH
      errors << "Название станции слишком короткое (минимум #{MIN_TITLE_LENGTH} символа)"
    elsif title.length > MAX_TITLE_LENGTH
      errors << "Название станции слишком длинное (максимум #{MAX_TITLE_LENGTH} символов)"
    end
  end

  def validate_format(errors)
    errors << 'Название станции содержит недопустимые символы' unless title !~ TITLE_FORMAT
  end
end

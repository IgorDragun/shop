# Подключаем библиотеку для работы парсера XML-файлов
require 'rexml/document'

# Подключаем классы с продуктами
require_relative 'product.rb'
require_relative 'book.rb'
require_relative 'film.rb'
require_relative 'disk.rb'

# Определяем перечень дочерних классов - виды продуктов
product_types = Product.product_types

# Определим переменную для ответа пользователя
choice = -1

# Запрашиваем у пользователя информацию о том, какой товар он хочет добавить
until (0...product_types.size).include?(choice)
  puts "Какой товар Вы бы хотели добавить?"
  product_types.each_with_index {|name, number| puts "#{number}: #{name.to_s}."}
  choice = STDIN.gets.chomp.to_i
end

# Запрашиваем у пользователя информацию о цене и количестве добавляемого товара
puts "Укажите стоимость товара в рублях:"
price = STDIN.gets.chomp.to_i

puts "Укажите, сколько едениц продукта осталось на складе:"
count = STDIN.gets.chomp.to_i

# Создаем объект для выбранного продукта
product = product_types[choice].new(price, count)

# Запрашиваем у пользователя дополнительные данные для выбранного продукта
product.read_from_console

# Сохраняем новый продукт в файл
product.save_to_xml("/data/products.xml")
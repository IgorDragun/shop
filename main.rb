# Подключаем библиотеку для работы с XML
require 'rexml/document'

# Подключаем все наши классы
require_relative 'product.rb'
require_relative 'book.rb'
require_relative 'film.rb'
require_relative 'disk.rb'

# определяем переменную для выбора пользователя и общей стоимости выбранных им товаров
choice = nil
total = 0

# Вызываем статический метод класса Product, который возвращает массив продуктов из файла
products = Product.read_from_xml("/data/products.xml")

# Отображаем пользователю список товаров и запрашиваем ввод данных
while choice != "x" && choice != "х"

  # Отображаем список товаров
  Product.showcase(products)

  # Запрашивает ввод данных
  choice = STDIN.gets.chomp

  if (choice != "x" && choice != "х") && (choice.to_i >= 0 && choice.to_i < products.size)
    product = products[choice.to_i]
    total += product.buy
  end
end

puts "Спасибо за покупки, с Вас #{total} рублей."
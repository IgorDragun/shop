class Product

  # Конструктор
  def initialize (price, count)
    @price = price
    @count = count
  end


  # Аксессоры
  attr_accessor(:price, :count)


  # Статический метод класса для считывания из указанного файла
  def self.read_from_xml(file_name)

    # Определяем путь к файлу
    file_path = File.dirname(__FILE__) + file_name

    # Если файл с продуктами не найден, то завершаем программу
    abort "Файл #{file_path} не найден!" unless File.exist?(file_path)

    # Иначе считываем файл xml через библиотеку REXML
    file = File.new(file_path, "r:UTF-8")
    doc = REXML::Document.new(file)
    file.close

    # Создадим пустой массив, куда будем складывать все продукты
    products = []

    # Создадим переменную для создания объекта текущего продукта
    product = nil

    # Проходим по всем продуктам из файла и считываем данные
    doc.elements.each("products/product") do |product_node|

      # price и count являются атрибутами products
      price = product_node.attributes["price"].to_i
      count = product_node.attributes["count"].to_i

      # в каждом продукте может быть только один вид продукта со своими атрибутами,
      # поэтому выполниться только один из циклов (для вида продукта, который содержится в products)
      product_node.each_element("book") do |book|

        # Создаем объект класса Book
        product = Book.new(price, count)

        # Находим значения title и author_name
        title = book.attributes["title"]
        author_name = book.attributes["author_name"]

        # Дополняем объект класса Book недостающей информацией
        product.update(title, author_name)
      end

      # По аналогии создаем циклы для класса Film и Disk
      product_node.each_element("film") do |film|
        product = Film.new(price, count)
        title = film.attributes["title"]
        director_name = film.attributes["director_name"]
        year = film.attributes["year"].to_i
        product.update(title, director_name, year)
      end

      product_node.each_element("disk") do |disk|
        product = Disk.new(price, count)
        album_name = disk.attributes["album_name"]
        artist_name = disk.attributes["artist_name"]
        genre = disk.attributes["genre"]
        product.update(album_name, artist_name, genre)
      end

      # Добавляем объект в массив продуктов
      products.push(product)
    end

    return products
  end


  # Статический метод (метод класса), который отображает список доступных продуктов
  def self.showcase(products)
    puts "Что бы Вы хотели купить?"

    products.each_with_index do |product, index|
      puts "#{index}. #{product}."
    end

    puts "x. Покинуть магазин.\n\n"
  end


  # Статический метод (метод класса), который возвращает список всех детей класса Product
  def self.product_types
    [Book, Film, Disk]
  end


  # Метод для обновления переменных экземпляра класса
  def update(price, count)
    @price = price
    @count = count
  end


  # Метод, который проверяет, можно ли купить товар
  def buy
    if @count > 0
      puts "* * * * *"
      puts "Вы купили товар #{info}"
      puts "* * * * *"

      @count -= 1
      @price
    else
      puts "К сожалению, такого товара больше нет. Вы можете выбрать что-нибудь другое:"
      0
    end
  end


  # Абстрактный метод для отображения инфо о конкретном продукте
  def info
  end


  # Абстрактный метод для заполнения полей из консоли
  def read_from_console
  end


  # Метод для сохранения нового продукта в файл
  def save_to_xml(file_name)

    # Определяем путь к файлу
    file_path = File.dirname(__FILE__) + file_name

    # Если файл с продуктами не найден, то завершаем программу
    abort "Файл #{file_path} не найден!" unless File.exist?(file_path)

    # Иначе считываем файл xml через библиотеку REXML
    file = File.new(file_path, "r:UTF-8")
    doc = REXML::Document.new(file)
    file.close

    # Добавляем в XML-структуру новый продукт
    file = File.new(file_path, "w:UTF-8")
    doc.root.add_element(self.to_xml)
    doc.write(file, 2)
    file.close
  end


  # Метод для добавления элементов в XML-файл
  def to_xml
    res = REXML::Element.new("product")
    res.attributes["price"] = @price
    res.attributes["count"] = @count
    res
  end


  # Переопредеяем метод to_s для объектов класса
  def to_s
    "цена - #{@price} рублей [осталось - #{@count}]"
  end

end
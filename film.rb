class Film < Product

  # Конструктор - используем конструктор родительского класса


  # Аксессоры
  attr_accessor(:price, :count, :title, :director, :year)


  # Метод для обновления уникальных для этого класса параметров title, director и year
  def update(title, director, year)
    @title = title
    @director = director
    @year = year
  end


  # Переопределяем метод info родительского класса
  def info
    "Фильм \"#{@title}\", #{@year} год, режиссер - #{@director}"
  end


  # Метод класса для заполнения данных из консоли
  def read_from_console
    puts "Укажите название фильма:"
    @title = STDIN.gets.chomp

    puts "Укажите режиссера:"
    @director = STDIN.gets.chomp

    puts "Укажите год фильма:"
    @year = STDIN.gets.chomp.to_i
  end


  # Метод для добавления элементов в XML-файл
  def to_xml
    product = super
    product.add_element("film", {
      "title" => @title,
      "director" => @director,
      "year" => @year
    })
    product
  end


  def to_s
    "#{info}, #{super}"
  end

end
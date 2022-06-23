class Book < Product

  # Конструктор - используем конструктор родительского класса


  # Аксессоры
  attr_accessor(:price, :count, :title, :author_name)


  # Метод для обновления уникальных для этого класса параметров title и author_name
  def update(title, author_name)
    @title = title
    @author_name = author_name
  end


  # Переопределяем метод info родительского класса
  def info
    "Книга \"#{@title}\", автор - #{@author_name}"
  end


  # Метод класса для заполнения данных из консоли
  def read_from_console
    puts "Укажите название книги:"
    @title = STDIN.gets.chomp

    puts "Укажите автора книги:"
    @author_name = STDIN.gets.chomp
  end


  # Метод для добавления элементов в XML-файл
  def to_xml
    product = super
    product.add_element("book", {
      "title" => @title,
      "author_name" => @author_name
    })
    product
  end


  # Переопределяем метод to_s родительского класса
  def to_s
    "#{info}, #{super}"
  end

end
class Disk < Product

  # Конструктор - используем конструктор родительского класса

  # Аксессоры
  attr_accessor(:price, :count, :album_name, :artist_name, :genre)

  # Метод для обновления уникальных для этого класса параметров album_name, artist_name и genre
  def update(album_name, artist_name, genre)
    @album_name = album_name
    @artist_name = artist_name
    @genre = genre
  end


  # Переопределяем метод info родительского класса
  def info
    "Диск #{@artist_name} - \"#{@album_name}\" (#{@genre})"
  end


  # Метод класса для заполнения данных из консоли
  def read_from_console
    puts "Укажите название альбома:"
    @album_name = STDIN.gets.chomp

    puts "Укажите артиста:"
    @artist_name = STDIN.gets.chomp

    puts "Укажите жанр:"
    @genre = STDIN.gets.chomp
  end


  # Метод для добавления элементов в XML-файл
  def to_xml
    product = super
    product.add_element("disk", {
      "album_name" => @album_name,
      "artist_name" => @artist_name,
      "genre" => @genre
    })
    product
  end


  # Переопределяем метод to_s родительского класса
  def to_s
    "#{info}, #{super}"
  end

end
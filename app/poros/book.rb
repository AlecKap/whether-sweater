class Book
  attr_reader :id,
              :destination,
              :forecast,
              :total_books_found,
              :books

  def initialize(data)
    @id = nil
    @destination = data[:destination]
    @forecast = data[:forecast]
    @total_books_found = data[:total_books_found]
    @books = data[:book_data]
  end
end

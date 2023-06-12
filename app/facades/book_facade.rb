class BookFacade < ForecastFacade
  def initialize(location, quantity)
    @location = location
    @quantity = quantity.to_i
  end

  def books
    Book.new(books_and_forecast)
  end

  def books_and_forecast
    {
      destination: @location,
      forecast: forecast,
      total_books_found: total_books_found,
      book_data: book_data
    }
  end

  def forecast
    {
      summary: weather_data(lat_long)[:current][:condition][:text],
      temperature: "#{weather_data(lat_long)[:current][:temp_f]} F"
    }
  end

  def total_books_found
    books_data[:numFound]
  end

  def book_data
    books_data[:docs][0..(@quantity - 1)].map do |book|
      {
        isbn: book[:isbn],
        title: book[:title_suggest],
        publisher: book[:publisher]
      }
    end
  end

  private

  def service
    @_book_service ||= OpenLibraryService.new
  end

  def books_data
    @_books_data ||= service.get_books_data(@location)
  end
end

class OpenLibraryService
  def get_books_data(location)
    get_url("/search.json?q=#{location}")
  end

  private
  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: 'https://openlibrary.org')
  end
end

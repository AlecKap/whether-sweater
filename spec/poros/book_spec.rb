require 'rails_helper'

RSpec.describe Book do
  it 'exists and has attributes' do
    test_book_data = {
      destination: 'denver,co',
      forecast: {
        summary: 'Clear',
        temperature: '55.42 F'
      },
      total_books_found: 758,
      book_data: [
        {
          isbn: [ '9780980200447' ],
          title: 'title yeah',
          publisher: [ 'Pragmatic Bookshelf' ]
        }
      ]
    }
    book = Book.new(test_book_data)

    expect(book).to be_a(Book)
    expect(book.destination).to eq('denver,co')
    expect(book.forecast).to be_a(Hash)
    expect(book.forecast[:summary]).to eq('Clear')
    expect(book.forecast[:temperature]).to eq('55.42 F')
    expect(book.total_books_found).to eq(758)
    expect(book.books).to be_an(Array)
    expect(book.books[0][:isbn]).to eq(['9780980200447'])
    expect(book.books[0][:title]).to eq('title yeah')
    expect(book.books[0][:publisher]).to eq(['Pragmatic Bookshelf'])
    expect(book.id).to eq(nil)
  end
end
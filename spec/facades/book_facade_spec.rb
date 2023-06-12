require 'rails_helper'

RSpec.describe BookFacade do
  describe 'instance methods' do
    before :each do
      location = 'denver,co'
      quantity = 5

      @facade = BookFacade.new(location, quantity)
    end

    describe 'book_data' do
      it 'returns book data', :vcr do
        expect(@facade.book_data).to be_an(Array)
        expect(@facade.book_data.count).to eq(5)
        expect(@facade.book_data[0]).to have_key(:isbn)
        expect(@facade.book_data[0]).to have_key(:title)
        expect(@facade.book_data[0]).to have_key(:publisher)
      end
    end

    describe 'total_books_found' do
      it 'returns the total number of books found', :vcr do
        expect(@facade.total_books_found).to eq(758)
      end
    end

    describe 'forecast' do
      it 'returns forecast data', :vcr do
        expect(@facade.forecast).to be_a(Hash)
        expect(@facade.forecast).to have_key(:summary)
        expect(@facade.forecast[:summary]).to be_a(String)
        expect(@facade.forecast).to have_key(:temperature)
        expect(@facade.forecast[:temperature]).to be_a(String)
      end
    end

    describe 'books_and_forecast' do
      it 'returns a hash with book data and forecast data', :vcr do
        expect(@facade.books_and_forecast).to be_a(Hash)
        expect(@facade.books_and_forecast).to have_key(:destination)
        expect(@facade.books_and_forecast[:destination]).to be_a(String)
        expect(@facade.books_and_forecast).to have_key(:forecast)
        expect(@facade.books_and_forecast[:forecast]).to be_a(Hash)
        expect(@facade.books_and_forecast).to have_key(:total_books_found)
        expect(@facade.books_and_forecast[:total_books_found]).to be_a(Integer)
        expect(@facade.books_and_forecast).to have_key(:book_data)
        expect(@facade.books_and_forecast[:book_data]).to be_an(Array)
      end
    end

    describe 'books' do
      it 'returns book objects', :vcr do
        expect(@facade.books).to be_a(Book)
      end
    end
  end
end
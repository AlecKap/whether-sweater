require 'rails_helper'

RSpec.describe 'Books & Forecast request' do
  describe 'happy path' do
    it 'can get a specific number of books & a forecast for a given location & quantity', :vcr do
      get '/api/v0/book-search?location=denver,co&quantity=5'

      expect(response).to be_successful
      expect(response.status).to eq(200)

      data = JSON.parse(response.body, symbolize_names: true)

      expect(data).to be_a(Hash)
      expect(data).to have_key(:data)

      expect(data[:data]).to have_key(:id)
      expect(data[:data][:id]).to eq(nil)
      expect(data[:data]).to have_key(:type)
      expect(data[:data][:type]).to eq('books')
      expect(data[:data]).to have_key(:attributes)

      attributes = data[:data][:attributes]
      expect(attributes[:destination]).to be_a(String)
      expect(attributes).to have_key(:forecast)
      expect(attributes[:forecast]).to be_a(Hash)
      expect(attributes[:forecast]).to have_key(:summary)
      expect(attributes[:forecast][:summary]).to be_a(String)
      expect(attributes[:forecast]).to have_key(:temperature)
      expect(attributes[:forecast][:temperature]).to be_a(String)
      expect(attributes).to have_key(:total_books_found)
      expect(attributes[:total_books_found]).to be_a(Integer)
      expect(attributes).to have_key(:books)
      expect(attributes[:books]).to be_an(Array)
      expect(attributes[:books].count).to eq(5)
      expect(attributes[:books][0]).to have_key(:isbn)
      expect(attributes[:books][0][:isbn]).to be_an(Array)
      expect(attributes[:books][0]).to have_key(:title)
      expect(attributes[:books][0][:title]).to be_a(String)
      expect(attributes[:books][0]).to have_key(:publisher)
      expect(attributes[:books][0][:publisher]).to be_an(Array)
    end
  end
end
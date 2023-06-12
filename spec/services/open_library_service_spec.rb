require 'rails_helper'

RSpec.describe OpenLibraryService do
  describe 'instance methods' do
    describe 'get_book_data' do
      it 'returns book data for a given location', :vcr do
        location = 'denver,co'
        service = OpenLibraryService.new.get_books_data(location)

        expect(service).to be_a(Hash)
        expect(service).to have_key(:numFound)
        expect(service[:numFound]).to be_a(Integer)
        expect(service).to have_key(:docs)
        expect(service[:docs]).to be_an(Array)
        expect(service[:docs][0]).to have_key(:isbn)
        expect(service[:docs][0][:isbn]).to be_an(Array)
        expect(service[:docs][0]).to have_key(:title)
        expect(service[:docs][0][:title]).to be_a(String)
        expect(service[:docs][0]).to have_key(:publisher)
        expect(service[:docs][0][:publisher]).to be_a(Array)
      
        # service[:docs].each do |book|
        #   expect(book).to have_key(:isbn)
        #   expect(book[:isbn]).to be_an(Array)
        #   expect(book).to have_key(:title)
        #   expect(book[:title]).to be_a(String)
        #   expect(book).to have_key(:publisher)
        #   expect(book[:publisher]).to be_a(Array)
        # end
      end
    end
  end
end

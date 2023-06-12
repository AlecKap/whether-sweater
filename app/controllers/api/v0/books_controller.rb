class Api::V0::BooksController < ApplicationController
  def index
    books = BookFacade.new(params[:location], params[:quantity]).books
    render json: BooksSerializer.new(books)
  end
end

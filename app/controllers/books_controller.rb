class BooksController < ApplicationController
  def index
    @books = Book.includes(:publisher)
  end
end

class BooksController < ApplicationController
  def index
    @books = Book.includes(:publisher, :authors, :evaluations)
  end
end

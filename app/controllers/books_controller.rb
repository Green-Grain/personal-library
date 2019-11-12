class BooksController < ApplicationController
  def index
    # @books = Book.all.includes(:user, :evaluation)
    @books = Book.all
  end
end

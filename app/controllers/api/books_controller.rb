class Api::BooksController < ApplicationController
  def index
    title   = params[:title]
    author  = params[:author]
    isbn    = params[:isbn]
    if title.empty? && author.empty? && isbn.empty?
      @books = Book.get_all(false)
    else
      @books = Book.search(title, author, isbn)
    end
    respond_to do |format|
      format.html
      format.json
    end
  end
end

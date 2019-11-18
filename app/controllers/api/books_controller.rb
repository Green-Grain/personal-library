class Api::BooksController < ApplicationController
  def index
    title   = params[:title]
    author  = params[:author]
    isbn    = params[:isbn]
    return nil if (title == "") && (author == "") && (isbn == "")
    @books = Book.search(title, author, isbn)
    respond_to do |format|
      format.html
      format.json
    end
  end
end

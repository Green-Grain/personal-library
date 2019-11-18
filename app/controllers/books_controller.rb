class BooksController < ApplicationController
  def index
    shelf_books = Book.includes(:publisher, :authors, :evaluations)
    @books = []
    shelf_books.each do |shelf_book|
      book = {title: shelf_book.title, isbn: shelf_book.isbn, image: shelf_book.image, link_url: shelf_book.link_url, publisher: shelf_book.publisher.name}
      authors = []
      shelf_book.authors.each do |author|
        authors << author.name
      end
      book.store(:authors, authors)
      @books << book
    end
  end

  def new
    keyword = get_keyword
    results = Book.find_rakuten_books(keyword[:title], keyword[:author], keyword[:isbn])
    @candidates = []
    results.each do |result|
      # @candidates << {title: result.title, author: result.author, isbn: result.isbn, image: result.large_image_url, link_url: result.item_url, publisher: shelf_book.publisher.name}
      @candidates << {title: result.title, authors: [result.author], isbn: result.isbn, image: result.large_image_url, link_url: result.item_url, publisher: result.publisher_name}
    end
  end

  def create
    redirect_to root_path
  end

  private
  def get_keyword
    params.permit(:title, :author, :isbn)
  end
end

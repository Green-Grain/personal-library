class BooksController < ApplicationController
  def index
    @books = Book.get_all
  end

  def new
    keyword = get_keyword
    results = Book.find_rakuten_books(keyword[:title], keyword[:author], keyword[:isbn])
    @candidates = []
    results.each do |result|
      @candidates << {title: result.title, authors: [result.author], isbn: result.isbn, image: result.large_image_url, link_url: result.item_url, publisher: result.publisher_name}
    end
  end

  def create
    book_info = get_book_info
    ActiveRecord::Base.transaction do 
      publisher = Publisher.find_or_create_by(name: book_info[:publisher])
      book = publisher.books.create(title: book_info[:title], isbn: book_info[:isbn], image: book_info[:image], link_url: book_info[:link_url])
      author =  Author.where('name = ?', "#{book_info[:author]}")
      if author.empty?  # author が新規
        author = book.authors.create(name: book_info[:author])
      else
        BookAuthor.create(book_id: book.id, author_id: author.ids)
      end
    end
    redirect_to root_path
  end

  private
  def get_keyword
    params.permit(:title, :author, :isbn)
  end

  def get_book_info
    params.permit(:title, :author, :publisher, :isbn, :image, :link_url)
  end
end

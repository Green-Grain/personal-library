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
    Book.create(get_book_info)
    render root_path
  end

  private
  def get_keyword
    params.permit(:title, :author, :isbn)
  end

  def get_book_info
    params.permit(:title, :author, :author_name, :@publisher_name, :isbn).merge(user_id: current_user.id)
  end
end

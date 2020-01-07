class BooksController < ApplicationController
  def index
    @books = Book.get_all
  end

  def new
    keyword = get_keyword
    @candidates = []
    results = Book.find_rakuten_books(keyword[:title], keyword[:author], keyword[:isbn])
    if nil == results
      return
    end
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
    respond_to do |format|
      format.html { redirect_to root_path }
      format.json
    end
  end

  def add_shelf
    # ユーザのMY書架に書籍を登録する
    BookUser.create!(get_bookmark_params)
    redirect_to action: 'index'
  end

  private
  def get_keyword
    params.permit(:title, :author, :isbn)
  end

  def get_book_info
    params.permit(:title, :author, :publisher, :isbn, :image, :link_url)
  end

  def get_bookmark_params
    {book_id: params.permit(:id)[:id]}.merge(user_id: current_user.id)
  end
end

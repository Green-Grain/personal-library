class Book < ApplicationRecord
  has_many :book_authors
  has_many :authors,  through: :book_authors
  has_many :book_users
  has_many :users,    through: :book_users
  has_many :evaluations
  belongs_to :publisher

  def self.find_title(keyword)
    self.includes(:publisher, :authors, :evaluations).where('title LIKE ?', "%#{keyword}%")
  end

  def self.find_isbn(keyword)
    self.includes(:publisher, :authors, :evaluations).where('isbn LIKE ?', "%#{keyword}%")
  end
  
  def self.find_auhtor_name(keyword)
    self.includes(:publisher, :authors, :evaluations).joins(:authors).where('authors.name LIKE ?', "%#{author}%")
  end

  def self.search(title, author, isbn)
    # 一気に検索したかったが適切な処理がわからないので、検索key毎の検索で妥協する
    books = nil
    if title != ""
      result = Book.find_title(title)
      (books == nil) ? books = result : books += result
    end
    if isbn != ""
      result = Book.find_isbn(isbn)
      (books == nil) ? books = result : books += result
    end
    if author != ""
      result = Book.find_author_name(author)
      (books == nil) ? books = result : books += result
    end
    # 重複している検索結果を排除
    books =  books.uniq
  end

  # 楽天APIで書籍を検索（新規登録候補）
  BOOK_GENRE_ID = '001'
  def find_rakuten_books(title, author, isbn)
    if isbn != ""
      puts "search by ISBN"
      results = RakutenWebService::Books::Book.search(isbn: isbn, booksGenreId: BOOK_GENRE_ID)
    else   # author と title での検索
      if (author != "") && (title != "")
        puts "search by author and title"
        results = RakutenWebService::Books::Book.search(title: title, author: author, booksGenreId: BOOK_GENRE_ID)
      elsif author != ""  # author のみの検索
        puts "search by author"
        results = RakutenWebService::Books::Book.search(author: author, booksGenreId: BOOK_GENRE_ID)
      else  # title のみの検索
        puts "search by title"
        results = RakutenWebService::Books::Book.search(title: title, booksGenreId: BOOK_GENRE_ID)
      end
    end
    puts "RakutenWebService::Books::Book.search result count: #{results.count}"
  end
end

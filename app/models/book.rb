class Book < ApplicationRecord
  has_many :book_authors
  has_many :authors,  through: :book_authors
  has_many :book_users
  has_many :users,    through: :book_users
  has_many :evaluations
  belongs_to :publisher

  # 全 book 検索
  def self.get_all(is_convert_to_hash = true)
    shelf_books = self.includes(:publisher, :authors, :evaluations)
    if true == is_convert_to_hash
      return restore_to_hash(shelf_books)
    else
      return shelf_books
    end
  end

  # user 登録済み book 検索
  def self.get_all_by_user(user_id)
    user = User.find(user_id)
    shelf_books = user.books.includes(:publisher, :authors, :evaluations)
    restore_to_hash(shelf_books)
  end

  # book が登録済みか？
  def self.registered?(user_id, book_id)
    Book.find(book_id).users.exists?(user_id)
  end

  def self.find_title(keyword)
    self.includes(:publisher, :authors, :evaluations).where('title LIKE ?', "%#{keyword}%")
  end

  def self.find_isbn(keyword)
    self.includes(:publisher, :authors, :evaluations).where('isbn LIKE ?', "%#{keyword}%")
  end
  
  def self.find_author_name(keyword)
    self.includes(:publisher, :authors, :evaluations).joins(:authors).where('authors.name LIKE ?', "%#{keyword}%")
  end

  # 曖昧検索
  def self.search(title, author, isbn)
    # 一気に検索したかったが適切な処理がわからないので、検索key毎の検索で妥協する('A`)
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
    books = books.uniq
  end

  # 楽天APIで書籍を検索（新規登録候補）
  BOOK_GENRE_ID = '001'
  def self.find_rakuten_books(title, author, isbn)
    if false == ApiHistory.is_usable?
      puts '*****************************************'
      puts '**** 楽天APIが使用できませんでした。 ****'
      puts '**** 当月のAPI使用回数が最大です。   ****'
      puts '*****************************************'
      return nil
    end
    results = nil
    if isbn != ""
      puts "search by ISBN"
      results = RakutenWebService::Books::Book.search(isbn: isbn, booksGenreId: BOOK_GENRE_ID)
    else
      if (author != "") && (title != "")   # author と title での検索
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
    ApiHistory.increment_call_count
    puts "RakutenWebService::Books::Book.search result count: #{results.count}" unless results != nil
    return results
  end

  # 本の評価件数を取得
  def get_evaluation_num(is_positive)
    positive_value = (true == is_positive) ? 1 : 0
    evaluations = self.evaluations.where('positive LIKE ?', "#{positive_value}")
    if evaluations.blank?
      return 0
    else
      puts evaluations[0].positive
      return evaluations.count
    end
  end

  def self.get_evaluation_num(book_id, is_positive)
    book = Book.find(book_id)
    if book.blank?
      return 0
    else
      return book.get_evaluation_num(is_positive)
    end
  end

  private
  def self.restore_to_hash(shelf_books)
    books = []
    shelf_books.each do |shelf_book|
      book = {id: shelf_book.id, title: shelf_book.title, isbn: shelf_book.isbn, image: shelf_book.image, link_url: shelf_book.link_url, publisher: shelf_book.publisher.name}
      authors = []
      shelf_book.authors.each do |author|
        authors << author.name
      end
      book.store(:authors, authors)
      books << book
    end
    return books
  end
end

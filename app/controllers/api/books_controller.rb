class Api::BooksController < ApplicationController
  def index
    title   = params[:title]
    author  = params[:author]
    isbn    = params[:isbn]
    return nil if (title == "") && (author == "") && (isbn == "")
    # 一気に検索したかったが適切な処理がわからないので、検索key毎の検索で妥協する
    @books = nil
    if title != ""
      result = Book.find_title(title)
      (@books == nil) ? @books = result : @books += result
    end
    if isbn != ""
      result = Book.find_isbn(isbn)
      (@books == nil) ? @books = result : @books += result
    end
    if author != ""
      result = Book.find_author_name(author)
      (@books == nil) ? @books = result : @books += result
    end
    # 重複している検索結果を排除
    @books =  @books.uniq
    respond_to do |format|
      format.html
      format.json
    end
  end
end

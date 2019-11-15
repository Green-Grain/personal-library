json.array! @books do |book|
  json.title        book.title
  json.authors      book.authors
  json.publisher    book.publisher
  json.isbn         book.isbn
  json.evaluations  book.evaluations
end

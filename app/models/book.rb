class Book < ApplicationRecord
  # has_many    :book_authors
  belongs_to  :author
  has_many    :book_users
  has_many    :evaluations
  belongs_to  :publisher
end

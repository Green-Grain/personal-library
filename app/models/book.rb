class Book < ApplicationRecord
  has_many :book_authors
  has_many :authors,  through: :book_authors
  has_many :book_users
  has_many :users,    through: :book_users
  has_many :evaluations
  belongs_to :publisher
end

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
  
end

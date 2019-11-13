class Book < ApplicationRecord
  has_many :book_authors
  has_many :authors,  through: :book_authors
  has_many :book_users
  has_many :users,    through: :book_users
  has_many :evaluations
  belongs_to :publisher

  # def self.get_books(user_id = nil)
  #   if user_id == nil
  #     return self.includes(:publisher, :authors, :evaluations)
  #   else
  #     books = self.includes(:publisher, :authors, :evaluations)
  #     return books.users.where("evaluations.user_id = #{user_id}")
  #   end
  # end

end

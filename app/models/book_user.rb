class BookUser < ApplicationRecord
  belongs_to :book
  belongs_to :user

  def self.is_registered?(user_id, book_id)
    BookUser.where('user_id = ? and book_id = ?', "#{user_id}", "#{book_id}").exists?
  end
end

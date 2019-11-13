class AddForeignKeyToBookUsers < ActiveRecord::Migration[5.2]
  def change
    add_foreign_key :book_users, :books, column: :book_id
    add_foreign_key :book_users, :users, column: :user_id
  end
end

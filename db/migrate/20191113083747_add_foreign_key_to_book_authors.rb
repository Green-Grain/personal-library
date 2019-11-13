class AddForeignKeyToBookAuthors < ActiveRecord::Migration[5.2]
  def change
    add_foreign_key :book_authors, :books, column: :book_id
    add_foreign_key :book_authors, :authors, column: :author_id
  end
end

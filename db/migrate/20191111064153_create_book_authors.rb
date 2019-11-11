class CreateBookAuthors < ActiveRecord::Migration[5.2]
  def change
    create_table :book_authors do |t|
      t.references  :book,      foriegn_key: true
      t.references  :author,      foriegn_key: true
    end
  end
end

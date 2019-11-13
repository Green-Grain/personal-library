class AddForeignKeyToBooks < ActiveRecord::Migration[5.2]
  def change
    add_foreign_key :books, :publishers, column: :publisher_id
  end
end
